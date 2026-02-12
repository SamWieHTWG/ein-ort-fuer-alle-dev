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
  let currentSize = $state(105);
  let dx = (0.4 + Math.random() * 0.4) * (Math.random() < 0.5 ? -1 : 1);
  let dy = (0.3 + Math.random() * 0.3) * (Math.random() < 0.5 ? -1 : 1);
  let animId: number;

  const desktopSize = 105;
  const mobileSize = 70;
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
      // On desktop, the container may be shorter than the bubble size,
      // so use negative minY to let bubbles float above
      const isMobile = window.innerWidth < mobileBreakpoint;
      if (isMobile) {
        return {
          minX: 0,
          maxX: rect.width - size,
          minY: 0,
          maxY: rect.height - size,
          available: rect.width >= size && rect.height >= size,
        };
      }
      // Desktop: bounce between top of page and bottom of header bar
      // minY: negative offset so bubbles can reach the top of the viewport
      // maxY: bottom of header bar, relative to the container's position
      const headerBar = container.parentElement as HTMLElement;
      const headerRect = headerBar ? headerBar.getBoundingClientRect() : rect;
      return {
        minX: 0,
        maxX: rect.width - size,
        minY: -rect.top,
        maxY: headerRect.bottom - rect.top - size,
        available: rect.width >= size && (headerRect.bottom) >= size * 0.5,
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

      if (bounced) {
        dx += (Math.random() - 0.5) * 0.5;
        dy += (Math.random() - 0.5) * 0.5;
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
  style="transform: translate({x}px, {y}px); z-index: {zIndex}; --hover-color: {hoverColor}; width: {currentSize}px; height: {currentSize}px;"
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
    fill: #fff;
    font-size: 11px;
    font-weight: 700;
    font-family: inherit;
  }

  a:hover circle {
    fill: var(--hover-color);
  }
</style>
