<script lang="ts">
  import LogoAnimation from '$lib/LogoAnimation.svelte';

  let menuOpen = $state(false);
</script>

<header>
  <div class="header-bar">
    <div class="logo-area">
      <a href="/" class="logo-link" aria-label="Zur Startseite"></a>
      <LogoAnimation />
    </div>

    <button class="hamburger" onclick={() => menuOpen = !menuOpen} aria-label="Menu">
      <span></span>
      <span></span>
      <span></span>
    </button>
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

  .header-bar {
    position: relative;
    padding: 1rem;
    display: flex;
    align-items: center;
    overflow: visible;
  }

  .header-bar::after {
    content: '';
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    height: 4px;
    background: #000;
  }

  .logo-area {
    width: 70%;
    flex-shrink: 0;
    text-decoration: none;
    display: block;
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
    align-items: flex-end;
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
