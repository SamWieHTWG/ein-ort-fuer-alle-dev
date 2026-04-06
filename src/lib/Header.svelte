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

    <button
      class="hamburger"
      class:open={menuOpen}
      onclick={() => menuOpen = !menuOpen}
      aria-label="Menu"
      aria-expanded={menuOpen}
    >
      <span></span>
      <span></span>
      <span></span>
    </button>
  </div>

  <nav class="nav-mobile" class:open={menuOpen} aria-hidden={!menuOpen}>
    <a href="/unser-parklet" onclick={() => menuOpen = false}>Unser Parklet</a>
    <a href="/mitmachen" onclick={() => menuOpen = false}>Mitmachen</a>
    <a href="/kontakt" onclick={() => menuOpen = false}>Kontakt</a>
  </nav>
</header>

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

  /* Hamburger → X animation */
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
    appearance: none;
  }

  .hamburger span {
    display: block;
    width: 2rem;
    height: 4px;
    background: #000;
    transition: transform 0.25s ease, opacity 0.25s ease;
    transform-origin: center;
  }

  .hamburger.open span:nth-child(1) {
    transform: translateY(9px) rotate(45deg);
  }

  .hamburger.open span:nth-child(2) {
    opacity: 0;
    transform: scaleX(0);
  }

  .hamburger.open span:nth-child(3) {
    transform: translateY(-9px) rotate(-45deg);
  }

  /* Nav slide animation */
  .nav-mobile {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 1rem;
    padding: 0 1rem;
    max-width: 1200px;
    margin: 0 auto;
    overflow: hidden;
    max-height: 0;
    transition: max-height 0.3s ease, padding 0.3s ease;
  }

  .nav-mobile.open {
    max-height: 200px;
    padding: 1rem;
  }

  .nav-mobile a {
    color: #000;
    text-decoration: none;
    font-size: 1.125rem;
  }
</style>
