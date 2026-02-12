<script lang="ts">
  import Bubble from '$lib/Bubble.svelte';

  let menuOpen = $state(false);
</script>

<header>
  <div class="header-bar">
    <a class="logo" href="/">
      <span class="logo-sub">Parklet im</span>
      <span class="logo-main">Lehen</span>
    </a>

    <div class="bubbles-desktop">
      <Bubble href="/mitmachen" label="Mitmachen" color="#7954A2" hoverColor="#2d1d3f" zIndex={12} />
      <Bubble href="/unser-parklet" label={"Unser\nParklet"} color="#D74237" hoverColor="#2d1d3f" zIndex={11} />
      <Bubble href="/veranstaltungen" label="Events" color="#82C340" hoverColor="#2d1d3f" zIndex={10} />
    </div>

    <button class="hamburger" onclick={() => menuOpen = !menuOpen} aria-label="Menu">
      <span></span>
      <span></span>
      <span></span>
    </button>
  </div>

  <div class="bubbles-mobile">
    <Bubble href="/mitmachen" label="Mitmachen" color="#7954A2" hoverColor="#2d1d3f" zIndex={12} />
    <Bubble href="/unser-parklet" label={"Unser\nParklet"} color="#D74237" hoverColor="#2d1d3f" zIndex={11} />
    <Bubble href="/veranstaltungen" label="Events" color="#82C340" hoverColor="#2d1d3f" zIndex={10} />
  </div>
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

  .header-bar {
    position: relative;
    padding: 1rem;
    display: flex;
    align-items: center;
    overflow: visible;
  }

  .bubbles-desktop {
    display: none;
    position: relative;
    flex: 1;
    align-self: stretch;
    overflow: visible;
  }

  .bubbles-mobile {
    position: relative;
    height: 120px;
    overflow: hidden;
  }

  @media (min-width: 640px) {
    .bubbles-desktop {
      display: block;
    }

    .bubbles-mobile {
      display: none;
    }
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
