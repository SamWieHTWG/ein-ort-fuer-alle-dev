<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<main>
  <Header />

  <section class="hero">
    <div class="hero-text">
      <h1>Ein Ort für ALLE</h1>
      <p class="tagline">Gemeinsam gestalten. Nachhaltig beleben. Im Viertel begegnen.</p>
    </div>
    <div class="hero-image">
      <img src="/B6.jpg" />
    </div>
  </section>
</main>

<style>
  main {
    padding: 2rem;
  }

  @media (min-width: 1024px) {
    main {
      padding: 3rem;
    }
  }

  @media (min-width: 1280px) {
    main {
      padding: 6rem;
    }
  }

  /* Hero */
  .hero {
    display: grid;
    grid-template-columns: 1fr;
    max-width: 1200px;
    margin: 0 auto;
    padding: 1rem;
  }

  @media (min-width: 1024px) {
    .hero {
      grid-template-columns: 1fr 2fr;
      padding: 2.5rem 1rem;
    }
  }

  .hero-text {
    order: 2;
    margin-top: 2rem;
  }

  @media (min-width: 1024px) {
    .hero-text {
      order: 0;
      margin-top: 0;
      padding-right: 2rem;
    }
  }

  h1 {
    font-size: 3.75rem;
    line-height: 4rem;
    text-transform: uppercase;
    font-weight: 900;
    color: #000;
    margin: 0;
  }

  @media (min-width: 1024px) {
    h1 {
      font-size: 6rem;
      line-height: 7rem;
    }
  }

  .tagline {
    margin-top: 0.5rem;
    font-size: 1.125rem;
    font-weight: 600;
    line-height: 1.5;
  }

  @media (min-width: 1024px) {
    .tagline {
      margin-top: 1rem;
    }
  }

  .hero-image {
    order: 1;
  }

  @media (min-width: 1024px) {
    .hero-image {
      order: 0;
    }
  }

  .hero-image img {
    width: 100%;
    height: auto;
    display: block;
  }
</style>
