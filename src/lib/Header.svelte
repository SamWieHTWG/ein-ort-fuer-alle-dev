<script lang="ts">
  import Bubble from '$lib/Bubble.svelte';
  import { COLOR_PRIMARY, COLOR_SECONDARY } from '$lib/constants';

  let menuOpen = $state(false);
</script>

<header>
  <div class="header-bar">
    <a class="logo" href="/">
      <img src="/anlehnen/logo.png" alt="Parklet im Lehen" />
    </a>

    <div class="bubbles-desktop">
      <Bubble href="/mitmachen" label="Mitmachen" color={COLOR_SECONDARY} hoverColor={COLOR_PRIMARY} zIndex={12} />
      <Bubble href="/unser-parklet" label={"Unser\nParklet"} color={COLOR_PRIMARY} hoverColor={COLOR_SECONDARY} zIndex={11} />
      <Bubble href="/kontakt" label="Kontakt" color={COLOR_PRIMARY} hoverColor={COLOR_SECONDARY} zIndex={10} />
    </div>

    <button class="hamburger" onclick={() => menuOpen = !menuOpen} aria-label="Menu">
      <span></span>
      <span></span>
      <span></span>
    </button>
  </div>

  <div class="bubbles-mobile">
    <Bubble href="/mitmachen" label="Mitmachen" color={COLOR_SECONDARY} hoverColor={COLOR_PRIMARY} zIndex={12} />
    <Bubble href="/unser-parklet" label={"Unser\nParklet"} color={COLOR_PRIMARY} hoverColor={COLOR_SECONDARY} zIndex={11} />
    <Bubble href="/kontakt" label="Kontakt" color={COLOR_PRIMARY} hoverColor={COLOR_SECONDARY} zIndex={10} />
  </div>
</header>

{#if menuOpen}
  <nav class="nav-mobile">
    <a href="/unser-parklet" onclick={() => menuOpen = false}>Unser Parklet</a>
    <a href="/mitmachen" onclick={() => menuOpen = false}>Mitmachen</a>
    <a href="/kontakt" onclick={() => menuOpen = false}>Kontakt</a>
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
    .header-bar {
      min-height: calc(105px * 1.5);
    }

    .bubbles-desktop {
      display: block;
    }

    .bubbles-mobile {
      display: none;
    }
  }

  .logo {
    display: block;
    text-decoration: none;
    user-select: none;
  }

  .logo img {
    height: 168px;
    width: auto;
    display: block;
  }

  @media (min-width: 640px) {
    .logo img {
      height: 224px;
    }

    .hamburger {
      display: none;
    }
  }

  .hamburger {
    position: relative;
    z-index: 20;
    margin-left: auto;
    margin-top: 0;
    margin-bottom: 0;
    background: none;
    border: none;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    gap: 5px;
    padding: 4px;
    -moz-appearance: none;
    appearance: none;
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
