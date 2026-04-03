<script lang="ts">
  import { onMount } from 'svelte';

  const LETTERS = ['A', 'N', 'L', 'E', 'H', 'N', 'E', 'N'];
  const HIGHLIGHT_INDEX = 5;
  const COLOR_RED = '#7a0000';
  const COLOR_ORANGE = '#cc7a00';

  // ── Toggle debug mode ──────────────────────────────────────
  let DEBUG = false;

  

  // ── Spline config ──────────────────────────────────────────
let splinePoints = [
    { x: 0.2908, y: 0.4187 },
    { x: 0.4800, y: 0.4129 },
    { x: 0.7069, y: 0.0429 },
    { x: 0.8602, y: 0.1758 }
  ];
  let tension = 0.00;


  const VW = 500;
  const VH = 145;
  const VX = 0;
  const VY = 90;

  function padPoints(pts) {
  const f = { x: 2 * pts[0].x - pts[1].x, y: 2 * pts[0].y - pts[1].y };
  const l = { x: 2 * pts.at(-1).x - pts.at(-2).x, y: 2 * pts.at(-1).y - pts.at(-2).y };
  return [f, ...pts, l];
}

  // ── Spline math ────────────────────────────────────────────
  function cardinalPoint(p0, p1, p2, p3, t, ten) {
    const s = (1 - ten) / 2;
    const t2 = t * t, t3 = t2 * t;
    return {
      x: (2*t3-3*t2+1)*p1.x + (t3-2*t2+t)*(p2.x-p0.x)*s + (-2*t3+3*t2)*p2.x + (t3-t2)*(p3.x-p1.x)*s,
      y: (2*t3-3*t2+1)*p1.y + (t3-2*t2+t)*(p2.y-p0.y)*s + (-2*t3+3*t2)*p2.y + (t3-t2)*(p3.y-p1.y)*s
    };
  }

  function cardinalTangent(p0, p1, p2, p3, t, ten) {
    const s = (1 - ten) / 2;
    const t2 = t * t;
    return {
      dx: (6*t2-6*t)*p1.x + (3*t2-4*t+1)*(p2.x-p0.x)*s + (-6*t2+6*t)*p2.x + (3*t2-2*t)*(p3.x-p1.x)*s,
      dy: (6*t2-6*t)*p1.y + (3*t2-4*t+1)*(p2.y-p0.y)*s + (-6*t2+6*t)*p2.y + (3*t2-2*t)*(p3.y-p1.y)*s
    };
  }

function sampleSpline(pts, t, ten) {
  const padded = padPoints(pts);
  const n = padded.length;
  const segments = n - 1;
  // map t to interior range [1 .. n-2]
  const scaled = 1 + t * (segments - 2);
  const seg = Math.min(Math.floor(scaled), segments - 2);
  const localT = scaled - seg;
  const p0 = padded[seg - 1];
  const p1 = padded[seg];
  const p2 = padded[seg + 1];
  const p3 = padded[seg + 2];
  const pos = cardinalPoint(p0, p1, p2, p3, localT, ten);
  const tan = cardinalTangent(p0, p1, p2, p3, localT, ten);
return { ...pos, rot: Math.atan2(tan.dy * VH, tan.dx * VW) * (180 / Math.PI) };
}

  function toSVG(p) {
    return { x: VX + p.x * VW, y: VY + p.y * VH, rot: p.rot };
  }

  // ── Arc-length reparameterization ──────────────────────────
function buildArcTable(pts: { x: number; y: number }[], ten: number, samples = 500) {
  const table: { t: number; arcLen: number }[] = [];
  let cumLen = 0;
  // Sample in normalized space, not SVG pixels
  let prev = sampleSpline(pts, 0, ten);
  table.push({ t: 0, arcLen: 0 });
  for (let i = 1; i <= samples; i++) {
    const t = i / samples;
    const curr = sampleSpline(pts, t, ten);
    // Scale by aspect ratio so x and y contribute correctly
    const dx = (curr.x - prev.x) * VW;
    const dy = (curr.y - prev.y) * VH;
    cumLen += Math.sqrt(dx * dx + dy * dy);
    table.push({ t, arcLen: cumLen });
    prev = curr;
  }
  return table;
}

  function tAtArcLen(table: { t: number; arcLen: number }[], targetLen: number) {
    let lo = 0, hi = table.length - 1;
    while (lo < hi - 1) {
      const mid = (lo + hi) >> 1;
      if (table[mid].arcLen < targetLen) lo = mid;
      else hi = mid;
    }
    const span = table[hi].arcLen - table[lo].arcLen;
    const frac = span > 0 ? (targetLen - table[lo].arcLen) / span : 0;
    return table[lo].t + frac * (table[hi].t - table[lo].t);
  }

  const N = LETTERS.length;

  $: endPos = (() => {
    const table = buildArcTable(splinePoints, tension);
    const totalLen = table[table.length - 1].arcLen;
    return LETTERS.map((_, i) => {
      const t = tAtArcLen(table, (i / (N - 1)) * totalLen);
      return toSVG(sampleSpline(splinePoints, t, tension));
    });
  })();

  $: avgY = endPos.reduce((sum, p) => sum + p.y, 0) / N;
  $: startPos = endPos.map((p) => ({ x: p.x, y: avgY, rot: 0 }));

  // ── Debug spline path for SVG ──────────────────────────────
  $: splinePath = (() => {
    const steps = 80;
    return Array.from({ length: steps + 1 }, (_, i) => {
      const p = toSVG(sampleSpline(splinePoints, i / steps, tension));
      return `${i === 0 ? 'M' : 'L'}${p.x.toFixed(2)},${p.y.toFixed(2)}`;
    }).join(' ');
  })();

  // ── Handle dragging ────────────────────────────────────────
  let svgEl: SVGSVGElement;
  let draggingIndex = -1;

  function svgCoords(e: MouseEvent | TouchEvent) {
    const src = (e as TouchEvent).touches ? (e as TouchEvent).touches[0] : e as MouseEvent;
    const rect = svgEl.getBoundingClientRect();
    return {
      x: ((src.clientX - rect.left) / rect.width) * VW + VX,
      y: ((src.clientY - rect.top) / rect.height) * (VH + VY)
    };
  }

  function onHandleDown(e: MouseEvent | TouchEvent, i: number) {
    if (!DEBUG) return;
    e.preventDefault();
    draggingIndex = i;
  }

  function onMouseMove(e: MouseEvent | TouchEvent) {
    if (draggingIndex < 0 || !DEBUG) return;
    const { x, y } = svgCoords(e);
    splinePoints = splinePoints.map((p, i) =>
      i === draggingIndex
        ? { x: Math.max(0, Math.min(1, (x - VX) / VW)), y: Math.max(0, Math.min(1, (y - VY) / VH)) }
        : p
    );
  }

  function onMouseUp() { draggingIndex = -1; }

  // ── Copied state ───────────────────────────────────────────
  let copied = false;
function copyParams() {
  const txt = `let splinePoints = [\n`
    + splinePoints.map(p => `    { x: ${p.x.toFixed(4)}, y: ${p.y.toFixed(4)} }`).join(',\n')
    + `\n  ];\n  let tension = ${tension.toFixed(2)};`;
  navigator.clipboard.writeText(txt);
  copied = true;
  setTimeout(() => copied = false, 1500);
}

  // ── Animation ──────────────────────────────────────────────
  let letterEls: SVGTextElement[] = [];
  let sectionEl: HTMLElement;

  onMount(async () => {
    const { gsap } = await import('gsap');


letterEls.forEach((el, i) => {
  gsap.set(el, {
    attr: { x: startPos[i].x, y: startPos[i].y },
    rotation: 0,
    svgOrigin: `${startPos[i].x} ${startPos[i].y}`
  });
});

    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting) {
gsap.to(letterEls, {
  attr: (i) => ({ x: endPos[i].x, y: endPos[i].y }),
  rotation: (i) => endPos[i].rot,
  svgOrigin: (i) => `${endPos[i].x} ${endPos[i].y}`,
  stagger: 0.05,
  duration: 1.6,
  ease: 'power2.inOut'
});
          observer.disconnect();
        }
      },
      { threshold: 0.4 }
    );
    observer.observe(sectionEl);
    return () => observer.disconnect();
  });
</script>

<section class="logo-animation" bind:this={sectionEl}>

  {#if DEBUG}
  <div class="debug-bar">
    <span class="debug-label">DEBUG</span>
    <label>Tension: {tension.toFixed(2)}
      <input type="range" min="0" max="1" step="0.05" bind:value={tension} />
    </label>
    <button on:click={copyParams}>{copied ? '✓ Copied!' : 'Copy params'}</button>
  </div>
  {/if}

  <!-- svelte-ignore a11y-no-static-element-interactions -->
  <svg
    bind:this={svgEl}
    viewBox="0 20 500 240"
    xmlns="http://www.w3.org/2000/svg"
    aria-label="ANLEHNEN"
    on:mousemove={onMouseMove}
    on:mouseup={onMouseUp}
    on:mouseleave={onMouseUp}
    on:touchmove|preventDefault={onMouseMove}
    on:touchend={onMouseUp}
    style="cursor: {DEBUG && draggingIndex >= 0 ? 'grabbing' : 'default'}"
  >
    {#if DEBUG}
      <!-- Spline curve -->
      <path d={splinePath} fill="none" stroke="#3b82f6" stroke-width="1" stroke-dasharray="4 3" opacity="0.6" />

      <!-- Control polygon -->
      <polyline
        points={splinePoints.map(p => `${VX + p.x * VW},${VY + p.y * VH}`).join(' ')}
        fill="none" stroke="#94a3b8" stroke-width="0.5" stroke-dasharray="2 2"
      />

      <!-- Control point handles -->
      {#each splinePoints as pt, i}
        <!-- svelte-ignore a11y-no-static-element-interactions -->
        <circle
          cx={VX + pt.x * VW}
          cy={VY + pt.y * VH}
          r="5"
          fill="white"
          stroke="#3b82f6"
          stroke-width="1.5"
          style="cursor: grab"
          on:mousedown={(e) => onHandleDown(e, i)}
          on:touchstart|preventDefault={(e) => onHandleDown(e, i)}
        />
        <text
          x={VX + pt.x * VW}
          y={VY + pt.y * VH - 7}
          text-anchor="middle"
          font-size="6"
          fill="#3b82f6"
          pointer-events="none"
        >P{i+1}</text>
      {/each}
    {/if}

{#each LETTERS as letter, i}
  <text
    bind:this={letterEls[i]}
    x={DEBUG ? endPos[i].x : startPos[i].x}
    y={DEBUG ? endPos[i].y : avgY}
    text-anchor="middle"
    dominant-baseline="central"
    font-family="Impact, 'Arial Black', sans-serif"
    font-size="62"
    font-weight="900"
    fill={i === HIGHLIGHT_INDEX ? COLOR_ORANGE : COLOR_RED}
    transform={DEBUG ? `rotate(${endPos[i].rot}, ${endPos[i].x}, ${endPos[i].y})` : ''}
    pointer-events={DEBUG ? 'none' : 'auto'}
  >{letter}</text>
{/each}

{#if DEBUG}
  <path d={splinePath} fill="none" stroke="#3b82f6" stroke-width="1" stroke-dasharray="4 3" opacity="0.6" />
  <polyline
    points={splinePoints.map(p => `${VX + p.x * VW},${VY + p.y * VH}`).join(' ')}
    fill="none" stroke="#94a3b8" stroke-width="0.5" stroke-dasharray="2 2"
  />
  {#each splinePoints as pt, i}
    <!-- svelte-ignore a11y-no-static-element-interactions -->
    <circle
      cx={VX + pt.x * VW}
      cy={VY + pt.y * VH}
      r="5"
      fill="white"
      stroke="#3b82f6"
      stroke-width="1.5"
      style="cursor: grab"
      on:mousedown={(e) => onHandleDown(e, i)}
      on:touchstart|preventDefault={(e) => onHandleDown(e, i)}
    />
    <text
      x={VX + pt.x * VW}
      y={VY + pt.y * VH - 7}
      text-anchor="middle"
      font-size="6"
      fill="#3b82f6"
      pointer-events="none"
    >P{i+1}</text>
  {/each}
{/if}

</section>

<div style="position:fixed; bottom:1rem; right:1rem; z-index:999;">
  <button class="debug-toggle" on:click={() => DEBUG = !DEBUG}>
    {DEBUG ? '✕ Exit debug' : '⚙ Debug'}
  </button>
</div>

<style>
  .logo-animation {
    margin: 2rem -2rem;
    padding: 1.5rem 0;
    position: relative;
  }
  svg {
    width: 100%;
    height: auto;
    display: block;
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
  .debug-bar button, .debug-toggle {
    padding: 4px 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    background: white;
    cursor: pointer;
    font-size: 13px;
  }
  .debug-toggle {
    background: #1e293b;
    color: white;
    border-color: #1e293b;
  }
  .debug-coords {
    font-size: 11px;
    font-family: monospace;
    color: #64748b;
    text-align: center;
    padding: 0.25rem 0;
  }
</style>