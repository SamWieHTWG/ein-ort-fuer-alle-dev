<script lang="ts">
  import LogoAnimation from '$lib/LogoAnimation.svelte';

  let menuOpen = $state(false);
</script>

<div class="logo-sticky">
  <div class="logo-area">
    <a href="/" class="logo-link" aria-label="Zur Startseite"></a>
    <LogoAnimation />
  </div>
</div>

<div class="hamburger-fixed">
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

  <nav class="nav-mobile" class:open={menuOpen} aria-hidden={!menuOpen}>
    <a href="/" onclick={() => menuOpen = false}>Startseite</a>
    <a href="/unser-parklet" onclick={() => menuOpen = false}>Unser Parklet</a>
    <a href="/mitmachen" onclick={() => menuOpen = false}>Mitmachen</a>
    <a href="/kontakt" onclick={() => menuOpen = false}>Kontakt</a>
  </nav>
</div>

<style>
  .logo-sticky {
    position: sticky;
    top: 0;
    z-index: 1;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
  }

  @media (min-width: 1024px) {
    .logo-sticky {
      padding: 0 3rem;
    }
  }

  .logo-area {
    width: 70%;
    padding: 1rem 0;
    text-decoration: none;
    display: block;
  }

  /* Fixed hamburger + nav in top-right corner */
  .hamburger-fixed {
    position: fixed;
    top: 1rem;
    right: 1rem;
    z-index: 200;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
  }

  .hamburger {
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

  /* Nav dropdown */
  .nav-mobile {
    background-color: #B1D4E0;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 1rem;
    padding: 0;
    overflow: hidden;
    max-height: 0;
    transition: max-height 0.3s ease, padding 0.3s ease;
    border-radius: 4px;
    margin-top: 0.5rem;
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
