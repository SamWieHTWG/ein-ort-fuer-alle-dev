<script lang="ts">
  import { onMount } from 'svelte';

  let el: HTMLAnchorElement;
  let x = $state(0);
  let y = $state(0);
  let visible = $state(true);
  let dx = 0.4 + Math.random() * 0.4;
  let dy = 0.3 + Math.random() * 0.3;
  let animId: number;

  const size = 105;

  onMount(() => {
    const header = el.parentElement as HTMLElement;
    if (!header) return;

    const logo = header.querySelector('.logo') as HTMLElement;
    const hamburger = header.querySelector('.hamburger') as HTMLElement;
    if (!logo || !hamburger) return;

    function getBounds() {
      const headerRect = header.getBoundingClientRect();
      const logoRect = logo.getBoundingClientRect();
      const hamburgerRect = hamburger.getBoundingClientRect();
      return {
        minX: logoRect.right - headerRect.left + 8,
        maxX: hamburgerRect.left - headerRect.left - size - 8,
        minY: -headerRect.top,
        maxY: headerRect.height - size,
        availableHeight: headerRect.top + headerRect.height,
      };
    }

    let bounds = getBounds();
    x = bounds.minX + Math.random() * Math.max(0, bounds.maxX - bounds.minX);
    y = Math.random() * Math.max(0, bounds.maxY - bounds.minY) + bounds.minY;

    function animate() {
      bounds = getBounds();

      visible = bounds.availableHeight >= size * 1;

      if (!visible) {
        animId = requestAnimationFrame(animate);
        return;
      }

      x += dx;
      y += dy;

      if (x <= bounds.minX || x >= bounds.maxX) {
        dx = -dx;
        x = Math.max(bounds.minX, Math.min(x, bounds.maxX));
      }
      if (y <= bounds.minY || y >= bounds.maxY) {
        dy = -dy;
        y = Math.max(bounds.minY, Math.min(y, bounds.maxY));
      }

      animId = requestAnimationFrame(animate);
    }

    animId = requestAnimationFrame(animate);

    return () => cancelAnimationFrame(animId);
  });
</script>

<a
  bind:this={el}
  id="SchwarzBlase"
  href="/mitmachen"
  class:hidden={!visible}
  style="transform: translate({x}px, {y}px)"
>
  <svg viewBox="0 0 70 70" xmlns="http://www.w3.org/2000/svg">
    <circle cx="35" cy="35" r="34" />
    <text x="35" y="36" text-anchor="middle" dominant-baseline="middle">Mitmachen</text>
  </svg>
</a>

<style>
  a {
    position: absolute;
    top: 0;
    left: 0;
    width: 105px;
    height: 105px;
    z-index: 10;
    cursor: pointer;
    text-decoration: none;
    will-change: transform;
  }

  a.hidden {
    display: none;
  }

  svg {
    width: 100%;
    height: 100%;
  }

  circle {
    fill: #0e9c26;
  }

  text {
    fill: #fff;
    font-size: 11px;
    font-weight: 700;
    font-family: inherit;
  }

  a:hover circle {
    fill: #0b7e1f;
  }
</style>
