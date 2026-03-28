<script lang="ts">
  import '../app.css';
  import { COLOR_PRIMARY, COLOR_SECONDARY, COLOR_BACKGROUND } from '$lib/constants';

  let { children } = $props();

  $effect(() => {
    const root = document.documentElement;
    root.style.setProperty('--color-primary', COLOR_PRIMARY);
    root.style.setProperty('--color-secondary', COLOR_SECONDARY);
    root.style.setProperty('--color-background', COLOR_BACKGROUND);
  });
</script>

{@render children()}
