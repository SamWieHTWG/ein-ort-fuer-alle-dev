<script lang="ts">
  import { onMount } from 'svelte';

  interface Props {
    href?: string;
    label?: string;
    color?: string;
    hoverColor?: string;
    zIndex?: number;
  }

  let { href = '/mitmachen', label = 'Mitmachen', color = '#7954A2', hoverColor = '#2d1d3f', zIndex = 10 }: Props = $props();

  let el: HTMLAnchorElement;
  let x = $state(0);
  let y = $state(0);
  let visible = $state(true);
  let dx = (0.4 + Math.random() * 0.4) * (Math.random() < 0.5 ? -1 : 1);
  let dy = (0.3 + Math.random() * 0.3) * (Math.random() < 0.5 ? -1 : 1);
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
    // Spread initial positions: divide area into 3 horizontal zones based on zIndex
    const zone = 12 - zIndex; // 0, 1, 2 for zIndex 12, 11, 10
    const rangeX = Math.max(0, bounds.maxX - bounds.minX);
    const zoneWidth = rangeX / 3;
    x = bounds.minX + zone * zoneWidth + Math.random() * zoneWidth;
    y = Math.random() * Math.max(0, bounds.maxY - bounds.minY) + bounds.minY;

   function animate() {
  bounds = getBounds();
  visible = bounds.availableHeight >= size * 1;

  if (!visible) {
    animId = requestAnimationFrame(animate);
    return;
  }

  // 1. Calculate current constant speed (magnitude) 
  // speed = sqrt(dx^2 + dy^2)
  const speed = Math.sqrt(dx * dx + dy * dy);

  x += dx;
  y += dy;

  let bounced = false;

  if (x <= bounds.minX || x >= bounds.maxX) {
    dx = -dx;
    x = Math.max(bounds.minX, Math.min(x, bounds.maxX));
    bounced = true;
  }
  
  if (y <= bounds.minY || y >= bounds.maxY) {
    dy = -dy;
    y = Math.max(bounds.minY, Math.min(y, bounds.maxY));
    bounced = true;
  }

  // 2. If a bounce happened, inject a tiny angle change but normalize speed
  if (bounced) {
    // Add a tiny bit of random variation to the components
    dx += (Math.random() - 0.5) * 0.5; 
    dy += (Math.random() - 0.5) * 0.5;

    // 3. Normalize the vector and multiply by the original speed
    const newMagnitude = Math.sqrt(dx * dx + dy * dy);
    dx = (dx / newMagnitude) * speed;
    dy = (dy / newMagnitude) * speed;
  }

  animId = requestAnimationFrame(animate);
}
    animId = requestAnimationFrame(animate);

    return () => cancelAnimationFrame(animId);
  });
</script>

<a
  bind:this={el}
  href={href}
  class:hidden={!visible}
  style="transform: translate({x}px, {y}px); z-index: {zIndex}; --hover-color: {hoverColor};"
>
  <svg viewBox="0 0 70 70" xmlns="http://www.w3.org/2000/svg">
    <circle cx="35" cy="35" r="34" fill={color} />
    {#each label.split('\n') as line, i}
      <text x="35" y={36 + (i - (label.split('\n').length - 1) / 2) * 13} text-anchor="middle" dominant-baseline="middle">{line}</text>
    {/each}
  </svg>
</a>

<style>
  a {
    position: absolute;
    top: 0;
    left: 0;
    width: 105px;
    height: 105px;
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
    transition: fill 0.2s;
  }

  text {
    fill: #fff;
    font-size: 11px;
    font-weight: 700;
    font-family: inherit;
  }

  a:hover circle {
    fill: var(--hover-color);
  }
</style>
