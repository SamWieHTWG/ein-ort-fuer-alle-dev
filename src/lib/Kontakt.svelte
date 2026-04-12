<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<Header />

<div class="content-border"></div>
<main>
  <section class="intro intro--full">
    <div class="intro-text block--secondary">
      <h1>Kontakt</h1>
      <p class="tagline">Komm vorbei oder melde dich — wir freuen uns auf dich!</p>
    </div>
  </section>

  <section class="content">
    <div class="block block--primary">
      <h2>So erreichst du uns</h2>
      <p>
        Am einfachsten erreichst du uns über unseren Instagram-Account. Dort posten wir
        auch Neuigkeiten und Fotos vom Parklet-Leben.
      </p>
      <ul>
        <li>Instagram: <a href="https://instagram.com/anlehnen.70180" target="_blank" rel="noopener">@anlehnen.70180</a></li>
        <li>E-Mail: <a href="mailto:info@anlehnen.eu">info@anlehnen.eu</a></li>
        <li>Website: <a href="https://anlehnen.eu" target="_blank" rel="noopener">anlehnen.eu</a></li>
      </ul>

      <h2>Wo du uns findest</h2>
      <p>
        Du findest uns in der Alexanderstraße im Lehenviertel, Stuttgart —
        am liebsten unter der großen Linde. Komm einfach vorbei!
      </p>
    </div>
  </section>
</main>

<style>
  :global(.intro--full) {
    display: block;
  }
</style>
