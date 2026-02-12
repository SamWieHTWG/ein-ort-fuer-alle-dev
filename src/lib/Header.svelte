<script lang="ts">
  import Bubble from '$lib/Bubble.svelte';

  let menuOpen = $state(false);
</script>

<header>
  <a class="logo" href="/">
    <span class="logo-sub">Parklet im</span>
    <span class="logo-main">Lehen</span>
  </a>

  <Bubble />

  <!-- <nav class="nav-desktop">
    <a href="/unser-parklet">Unser Parklet</a>
    <a href="/mitmachen">Mitmachen</a>
    <a href="/">Bewerben</a>
    <a href="/veranstaltungen">Veranstaltungen</a>
  </nav> -->

  <button class="hamburger" onclick={() => menuOpen = !menuOpen} aria-label="Menu">
    <span></span>
    <span></span>
    <span></span>
  </button>
</header>

{#if menuOpen}
  <nav class="nav-mobile">
    <a href="/unser-parklet" onclick={() => menuOpen = false}>Unser Parklet</a>
    <a href="/mitmachen" onclick={() => menuOpen = false}>Mitmachen</a>
    <a href="/veranstaltungen" onclick={() => menuOpen = false}>Veranstaltungen</a>
  </nav>
{/if}

<style>
  header {
    position: relative;
    max-width: 1200px;
    margin: 0 auto;
    padding: 1rem;
    display: flex;
    align-items: center;
  }

  header::after {
    content: '';
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    height: 4px;
    background: #000;
  }

  .logo {
    display: flex;
    flex-direction: column;
    line-height: 1;
    text-decoration: none;
    color: #000;
    text-transform: uppercase;
    user-select: none;
  }

  .logo-sub {
    font-size: 0.875rem;
    font-weight: 700;
  }

  .logo-main {
    font-size: 1.5rem;
    font-weight: 900;
  }

  .nav-desktop {
    display: none;
    gap: 4rem;
    margin-left: 8rem;
  }

  @media (min-width: 640px) {
    .nav-desktop {
      display: flex;
    }

    .hamburger {
      display: none;
    }
  }

  .nav-desktop a {
    color: #000;
    text-decoration: none;
    transition: color 0.2s;
  }

  .nav-desktop a:hover {
    color: #666;
  }

  .hamburger {
    position: relative;
    z-index: 20;
    margin-left: auto;
    background: none;
    border: none;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    gap: 5px;
    padding: 4px;
  }

  .hamburger span {
    display: block;
    width: 2rem;
    height: 4px;
    background: #000;
  }

  .nav-mobile {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    padding: 1rem;
    max-width: 1200px;
    margin: 0 auto;
  }

  .nav-mobile a {
    color: #000;
    text-decoration: none;
    font-size: 1.125rem;
  }
</style>
