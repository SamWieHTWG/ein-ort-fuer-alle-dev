<script lang="ts">
  import { onMount } from 'svelte';

  interface Props {
    href?: string;
    label?: string;
    color?: string;
    hoverColor?: string;
    textColor?: string;
    hoverTextColor?: string;
    zIndex?: number;
    speed?: number;
  }

  let { href = '/mitmachen', label = 'Mitmachen', color = '#7954A2', hoverColor = '#2d1d3f', textColor = '#fff', hoverTextColor = '#fff', zIndex = 10, speed = 1 }: Props = $props();

  let el: HTMLAnchorElement;
  let x = $state(0);
  let y = $state(0);
  let visible = $state(true);
  let currentSize = $state(105);
  let dx = (0.4 + Math.random() * 0.4) * (Math.random() < 0.5 ? -1 : 1);
  let dy = (0.3 + Math.random() * 0.3) * (Math.random() < 0.5 ? -1 : 1);
  let animId: number;

  const desktopSize = 155;
  const mobileSize = 105;
  const mobileBreakpoint = 640;

  function getSize() {
    return window.innerWidth < mobileBreakpoint ? mobileSize : desktopSize;
  }

  onMount(() => {
    const container = el.parentElement as HTMLElement;
    if (!container) return;

    currentSize = getSize();

    function getBounds() {
      const size = getSize();
      const rect = container.getBoundingClientRect();
      return {
        minX: 0,
        maxX: rect.width - size,
        minY: 0,
        maxY: rect.height - size,
        available: rect.width >= size && rect.height >= size,
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
      currentSize = getSize();
      visible = bounds.available;

      if (!visible) {
        animId = requestAnimationFrame(animate);
        return;
      }

      const isMobile = window.innerWidth < mobileBreakpoint;
      const speedMultiplier = isMobile ? speed * 0.5 : speed;
      const magnitude = Math.sqrt(dx * dx + dy * dy);

      x += dx * speedMultiplier;
      y += dy * speedMultiplier;

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

      if (bounced) {
        dx += (Math.random() - 0.5) * 0.5;
        dy += (Math.random() - 0.5) * 0.5;
        const newMagnitude = Math.sqrt(dx * dx + dy * dy);
        dx = (dx / newMagnitude) * magnitude;
        dy = (dy / newMagnitude) * magnitude;
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
  style="transform: translate({x}px, {y}px); z-index: {zIndex}; --hover-color: {hoverColor}; --text-color: {textColor}; --hover-text-color: {hoverTextColor}; width: {currentSize}px; height: {currentSize}px;"
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
    fill: var(--text-color);
    font-size: 11px;
    font-weight: 700;
    font-family: inherit;
    transition: fill 0.2s;
  }

  a:hover circle {
    fill: var(--hover-color);
  }

  a:hover text {
    fill: var(--hover-text-color);
  }
</style>
