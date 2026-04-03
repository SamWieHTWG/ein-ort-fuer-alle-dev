<svelte:head>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@900&display=swap" rel="stylesheet">
</svelte:head>

<script lang="ts">
  import { onMount } from 'svelte';

  const LETTERS = ['A', 'N', 'L', 'E', 'H', 'N', 'E', 'N'];
  const HIGHLIGHT_INDEX = 5;
  const COLOR_RED = '#7a0000';
  const COLOR_ORANGE = '#cc7a00';

  let DEBUG = false;

  let splinePoints = [
    { x: 0.2908, y: 0.4187 },
    { x: 0.4800, y: 0.4129 },
    { x: 0.6410, y: 0.1970 },
    { x: 0.7805, y: 0.1161 },
    { x: 0.8687, y: 0.2260 },
    { x: 0.9346, y: 0.4399 }
  ];
  let tension = 0.00;

  const VW = 500;
  const VH = 145;
  const VY = 90;
  const TOTAL_H = VH + VY;

  // ── Spline math ────────────────────────────────────────────
  function padPoints(pts: { x: number; y: number }[]) {
    const f = { x: 2 * pts[0].x - pts[1].x, y: 2 * pts[0].y - pts[1].y };
    const l = { x: 2 * pts.at(-1)!.x - pts.at(-2)!.x, y: 2 * pts.at(-1)!.y - pts.at(-2)!.y };
    return [f, ...pts, l];
  }

  function cardinalPoint(p0: any, p1: any, p2: any, p3: any, t: number, ten: number) {
    const s = (1 - ten) / 2, t2 = t * t, t3 = t2 * t;
    return {
      x: (2*t3-3*t2+1)*p1.x + (t3-2*t2+t)*(p2.x-p0.x)*s + (-2*t3+3*t2)*p2.x + (t3-t2)*(p3.x-p1.x)*s,
      y: (2*t3-3*t2+1)*p1.y + (t3-2*t2+t)*(p2.y-p0.y)*s + (-2*t3+3*t2)*p2.y + (t3-t2)*(p3.y-p1.y)*s
    };
  }

  function cardinalTangent(p0: any, p1: any, p2: any, p3: any, t: number, ten: number) {
    const s = (1 - ten) / 2, t2 = t * t;
    return {
      dx: (6*t2-6*t)*p1.x + (3*t2-4*t+1)*(p2.x-p0.x)*s + (-6*t2+6*t)*p2.x + (3*t2-2*t)*(p3.x-p1.x)*s,
      dy: (6*t2-6*t)*p1.y + (3*t2-4*t+1)*(p2.y-p0.y)*s + (-6*t2+6*t)*p2.y + (3*t2-2*t)*(p3.y-p1.y)*s
    };
  }

  function sampleSpline(pts: { x: number; y: number }[], t: number, ten: number) {
    const padded = padPoints(pts), n = padded.length, segs = n - 1;
    const scaled = 1 + t * (segs - 2);
    const seg = Math.min(Math.floor(scaled), segs - 2);
    const lt = scaled - seg;
    const p0 = padded[seg - 1], p1 = padded[seg], p2 = padded[seg + 1], p3 = padded[seg + 2];
    const pos = cardinalPoint(p0, p1, p2, p3, lt, ten);
    const tan = cardinalTangent(p0, p1, p2, p3, lt, ten);
    return { ...pos, rot: Math.atan2(tan.dy * VH, tan.dx * VW) * (180 / Math.PI) };
  }

  function buildArcTable(pts: { x: number; y: number }[], ten: number, samples = 500) {
    const table: { t: number; arcLen: number }[] = [{ t: 0, arcLen: 0 }];
    let cum = 0, prev = sampleSpline(pts, 0, ten);
    for (let i = 1; i <= samples; i++) {
      const t = i / samples, curr = sampleSpline(pts, t, ten);
      const dx = (curr.x - prev.x) * VW, dy = (curr.y - prev.y) * VH;
      cum += Math.sqrt(dx * dx + dy * dy);
      table.push({ t, arcLen: cum }); prev = curr;
    }
    return table;
  }

  function tAtArcLen(table: { t: number; arcLen: number }[], target: number) {
    let lo = 0, hi = table.length - 1;
    while (lo < hi - 1) { const m = (lo + hi) >> 1; table[m].arcLen < target ? lo = m : hi = m; }
    const span = table[hi].arcLen - table[lo].arcLen;
    const frac = span > 0 ? (target - table[lo].arcLen) / span : 0;
    return table[lo].t + frac * (table[hi].t - table[lo].t);
  }

  // ── Computed positions ─────────────────────────────────────
  const N = LETTERS.length;
  const FONT_PAD = 40; // half glyph height approx

  $: endPos = (() => {
    const table = buildArcTable(splinePoints, tension);
    const total = table[table.length - 1].arcLen;
    return LETTERS.map((_, i) => {
      const t = tAtArcLen(table, (i / (N - 1)) * total);
      const s = sampleSpline(splinePoints, t, tension);
      return { x: s.x * VW, y: VY + s.y * VH, rot: s.rot };
    });
  })();

  $: avgY = endPos.reduce((sum, p) => sum + p.y, 0) / N;

  // Tight bounding box around all positions (start + end)
  $: bbox = (() => {
    const allX = endPos.map(p => p.x);
    const allY = [...endPos.map(p => p.y), avgY];
    return {
      x0: Math.max(0, Math.min(...allX) - FONT_PAD),
      y0: Math.max(0, Math.min(...allY) - FONT_PAD),
      x1: Math.min(VW, Math.max(...allX) + FONT_PAD),
      y1: Math.min(TOTAL_H, Math.max(...allY) + FONT_PAD)
    };
  })();

  $: bboxW = bbox.x1 - bbox.x0;
  $: bboxH = bbox.y1 - bbox.y0;

  // Remap positions to tight bbox percentages
  $: startPcts = endPos.map(p => ({
    x: ((p.x - bbox.x0) / bboxW * 100),
    y: ((avgY - bbox.y0) / bboxH * 100)
  }));

  $: endPcts = endPos.map(p => ({
    x: ((p.x - bbox.x0) / bboxW * 100),
    y: ((p.y - bbox.y0) / bboxH * 100),
    rot: p.rot
  }));

  // ── Animation trigger ──────────────────────────────────────
  let animated = false;
  let sectionEl: HTMLElement;

  onMount(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting) {
          animated = true;
          observer.disconnect();
        }
      },
      { threshold: 0.4 }
    );
    observer.observe(sectionEl);
    return () => observer.disconnect();
  });

  // ── Debug: canvas drawing ──────────────────────────────────
  let canvasEl: HTMLCanvasElement;
  let wrapEl: HTMLElement;

  function drawDebug() {
    if (!canvasEl || !wrapEl) return;
    const rect = wrapEl.getBoundingClientRect();
    canvasEl.width = rect.width;
    canvasEl.height = rect.height;
    const ctx = canvasEl.getContext('2d')!;
    ctx.clearRect(0, 0, canvasEl.width, canvasEl.height);
    const sx = rect.width / bboxW, sy = rect.height / bboxH;

    function toCanvas(absX: number, absY: number) {
      return { px: (absX - bbox.x0) * sx, py: (absY - bbox.y0) * sy };
    }

    // spline curve
    ctx.beginPath();
    ctx.strokeStyle = '#3b82f6'; ctx.lineWidth = 1; ctx.setLineDash([4, 3]);
    for (let i = 0; i <= 80; i++) {
      const s = sampleSpline(splinePoints, i / 80, tension);
      const { px, py } = toCanvas(s.x * VW, VY + s.y * VH);
      i === 0 ? ctx.moveTo(px, py) : ctx.lineTo(px, py);
    }
    ctx.stroke(); ctx.setLineDash([]);

    // control polygon
    ctx.beginPath(); ctx.strokeStyle = '#94a3b8'; ctx.lineWidth = 0.5; ctx.setLineDash([2, 2]);
    splinePoints.forEach((p, i) => {
      const { px, py } = toCanvas(p.x * VW, VY + p.y * VH);
      i === 0 ? ctx.moveTo(px, py) : ctx.lineTo(px, py);
    });
    ctx.stroke(); ctx.setLineDash([]);

    // handles
    splinePoints.forEach((p, i) => {
      const { px, py } = toCanvas(p.x * VW, VY + p.y * VH);
      ctx.beginPath(); ctx.arc(px, py, 5, 0, Math.PI * 2);
      ctx.fillStyle = '#fff'; ctx.fill();
      ctx.strokeStyle = '#3b82f6'; ctx.lineWidth = 1.5; ctx.stroke();
      ctx.fillStyle = '#3b82f6'; ctx.font = '10px sans-serif'; ctx.textAlign = 'center';
      ctx.fillText('P' + (i + 1), px, py - 8);
    });
  }

  $: if (DEBUG && splinePoints && tension !== undefined) {
    // tick reactivity then draw
    requestAnimationFrame(drawDebug);
  }

  // ── Debug: drag ────────────────────────────────────────────
  let draggingIndex = -1;

  function onHandleDown(e: MouseEvent | TouchEvent) {
    if (!DEBUG || !wrapEl) return;
    const rect = wrapEl.getBoundingClientRect();
    const src = (e as TouchEvent).touches ? (e as TouchEvent).touches[0] : e as MouseEvent;
    const mx = src.clientX - rect.left, my = src.clientY - rect.top;
    const sx = rect.width / bboxW, sy = rect.height / bboxH;
    splinePoints.forEach((p, i) => {
      const px = (p.x * VW - bbox.x0) * sx, py = (VY + p.y * VH - bbox.y0) * sy;
      if (Math.hypot(mx - px, my - py) < 12) draggingIndex = i;
    });
  }

  function onMove(e: MouseEvent | TouchEvent) {
    if (draggingIndex < 0 || !DEBUG || !wrapEl) return;
    const rect = wrapEl.getBoundingClientRect();
    const src = (e as TouchEvent).touches ? (e as TouchEvent).touches[0] : e as MouseEvent;
    const relX = (src.clientX - rect.left) / rect.width;
    const relY = (src.clientY - rect.top) / rect.height;
    // map back from bbox-relative to spline-normalized
    const absX = bbox.x0 + relX * bboxW;
    const absY = bbox.y0 + relY * bboxH;
    splinePoints = splinePoints.map((p, i) =>
      i === draggingIndex
        ? { x: Math.max(0, Math.min(1, absX / VW)), y: Math.max(0, Math.min(1, (absY - VY) / VH)) }
        : p
    );
  }

  function onUp() { draggingIndex = -1; }

  // ── Debug helpers ──────────────────────────────────────────
  let copied = false;

  function copyParams() {
    const txt = `let splinePoints = [\n`
      + splinePoints.map(p => `    { x: ${p.x.toFixed(4)}, y: ${p.y.toFixed(4)} }`).join(',\n')
      + `\n  ];\n  let tension = ${tension.toFixed(2)};`;
    navigator.clipboard.writeText(txt);
    copied = true;
    setTimeout(() => (copied = false), 1500);
  }

  function addPoint() {
    const last = splinePoints.at(-1)!;
    const prev = splinePoints.at(-2)!;
    splinePoints = [...splinePoints, {
      x: Math.min(1, last.x + (last.x - prev.x) * 0.5),
      y: last.y
    }];
  }

  function removePoint() {
    if (splinePoints.length > 2) {
      splinePoints = splinePoints.slice(0, -1);
    }
  }
</script>

<!-- svelte-ignore a11y-no-static-element-interactions -->
<section
  class="logo-animation"
  bind:this={sectionEl}
  on:mousedown={onHandleDown}
  on:mousemove={onMove}
  on:mouseup={onUp}
  on:mouseleave={onUp}
  on:touchstart|preventDefault={onHandleDown}
  on:touchmove|preventDefault={onMove}
  on:touchend={onUp}
>
  {#if DEBUG}
    <div class="debug-bar">
      <span class="debug-label">DEBUG</span>
      <label>Tension: {tension.toFixed(2)}
        <input type="range" min="0" max="1" step="0.05" bind:value={tension} />
      </label>
      <button on:click={copyParams}>{copied ? '✓ Copied!' : 'Copy params'}</button>
      <button on:click={addPoint}>+ Point</button>
      <button on:click={removePoint} disabled={splinePoints.length <= 2}>− Point</button>
    </div>
  {/if}

  <div class="logo-wrap" bind:this={wrapEl} style="aspect-ratio: {bboxW.toFixed(1)} / {bboxH.toFixed(1)}">
    {#if DEBUG}
      <canvas class="debug-canvas" bind:this={canvasEl}></canvas>
    {/if}

    {#each LETTERS as letter, i}
      <span
        class="letter"
        class:animate={animated || DEBUG}
        style="
          --c: {i === HIGHLIGHT_INDEX ? COLOR_ORANGE : COLOR_RED};
          left: {(animated || DEBUG) ? endPcts[i].x : startPcts[i].x}%;
          top: {(animated || DEBUG) ? endPcts[i].y : startPcts[i].y}%;
          --er: {endPcts[i].rot.toFixed(2)}deg;
          --d: {i * 50}ms;
        "
      >{letter}</span>
    {/each}
  </div>
</section>

<div class="debug-toggle-wrap">
  <button class="debug-toggle" on:click={() => (DEBUG = !DEBUG)}>
    {DEBUG ? '✕ Exit debug' : '⚙ Debug'}
  </button>
</div>

<style>

  .logo-animation {
    margin: 0;
    padding: 0;
    position: relative;
  }

  .logo-wrap {
    position: relative;
    width: 100%;
  }

  .letter {
    position: absolute;
    font-family: 'Montserrat', sans-serif;
    font-size: clamp(32px, 12.4vw, 74px);
    font-weight: 900;
    line-height: 1;
    color: var(--c);
    transform: translate(-50%, -50%) rotate(0deg);
    will-change: left, top, transform;
    pointer-events: none;
    user-select: none;
    white-space: nowrap;
    transition: left 1.6s cubic-bezier(0.45, 0.05, 0.55, 0.95),
                top 1.6s cubic-bezier(0.45, 0.05, 0.55, 0.95),
                transform 1.6s cubic-bezier(0.45, 0.05, 0.55, 0.95);
    transition-delay: var(--d);
  }

  .letter.animate {
    transform: translate(-50%, -50%) rotate(var(--er));
  }

  .debug-canvas {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 10;
  }

  .debug-bar {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 0.4rem 1rem;
    background: #f0f4ff;
    border: 1px solid #c7d7ff;
    border-radius: 6px;
    margin-bottom: 0.5rem;
    font-size: 13px;
  }

  .debug-label {
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.08em;
    color: #3b82f6;
    background: #dbeafe;
    padding: 2px 6px;
    border-radius: 4px;
  }

  .debug-bar label {
    display: flex;
    align-items: center;
    gap: 0.4rem;
    color: #444;
  }

  .debug-bar button {
    padding: 4px 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    background: white;
    cursor: pointer;
    font-size: 13px;
  }

  .debug-toggle-wrap {
    position: fixed;
    bottom: 1rem;
    right: 1rem;
    z-index: 999;
  }

  .debug-toggle {
    padding: 4px 10px;
    border-radius: 6px;
    border: 1px solid #1e293b;
    background: #1e293b;
    color: white;
    cursor: pointer;
    font-size: 13px;
  }
</style>