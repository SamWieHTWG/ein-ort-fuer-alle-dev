<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<Header />

<div class="content-border"></div>
<main>
  <section class="intro intro--full">
    <div class="intro-text block--secondary">
      <h1>Mit&shy;machen</h1>
      <p class="tagline">Das Parklet lebt davon, dass viele Menschen sich beteiligen. Mach mit!</p>
    </div>
  </section>

  <section class="content">

    <div class="pair">
      <div class="block block--primary">
        <h2>Gemeinsam gestalten</h2>
        <p>
          Das Parklet soll ein offener Ort für die Nachbar*innenschaft werden — getragen von
          Menschen aus dem Viertel, für Menschen aus dem Viertel. Jede*r ist eingeladen
          mitzumachen: beim Aufbau, bei der Gestaltung oder einfach durch die Nutzung.
        </p>
        <p>
          Oder einfach dadurch, dass du den Ort nutzt und mit Leben füllst.
        </p>
      </div>
      <div class="pair-img pair-img--double">
        <img src="/B4.jpg" alt="Gemeinschaft am Parklet" />
        <img src="/B6.jpg" alt="Nachbarschaft im Austausch" />
      </div>
    </div>

    <div class="pair reverse">
      <div class="block block--secondary">
        <h2>Wie du dich einbringen kannst</h2>
        <p>Zum Beispiel:</p>
        <ul>
          <li>Beim Mitbauen und Reparieren</li>
          <li>Beim Gestalten und Planen</li>
          <li>Mit Grafikdesign für die Beschilderung</li>
          <li>Mit Texten oder Öffentlichkeitsarbeit</li>
          <li>Mit Spielideen für Kinder</li>
          <li>Mit kleinen Workshops</li>
          <li>Beim Gießen der Pflanzen</li>
          <li>Beim Nähen wetterfester Sitzkissen</li>
          <li>Beim Organisieren von Nachbar*innenschaftsessen</li>
          <li>Beim Aufräumen und Sauberhalten</li>
        </ul>
        <p>Du hast eine eigene Idee? Dann melde dich bei uns!</p>
      </div>
      <div class="pair-img">
        <img src="/B5.jpg" alt="Parklet Begrünung und Pflege" />
      </div>
    </div>

    <div class="pair">
      <div class="block block--primary">
        <h2>Kontakt</h2>
        <p>
          Wenn du Lust hast mitzumachen oder einfach neugierig bist, melde dich gerne:
        </p>
        <ul class="contact-list">
          <li>E-Mail: <a href="mailto:info@anlehnen.eu">info@anlehnen.eu</a></li>
          <li>Instagram: <a href="https://instagram.com/anlehnen.70180" target="_blank" rel="noopener">@anlehnen.70180</a></li>
        </ul>
      </div>
      <div class="pair-img pair-img--double">
        <img src="/B2.jpg" alt="Veranstaltung am Parklet" />
        <img src="/B7.jpg" alt="Leben auf dem Parklet" />
      </div>
    </div>

  </section>
</main>

<style>
  :global(.intro--full) {
    display: block;
  }

  .pair {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 2.5rem;
    align-items: stretch;
    margin-bottom: 3rem;
  }

  .pair.reverse > :first-child { order: 2; }
  .pair.reverse > :last-child  { order: 1; }

  .pair .block {
    margin-bottom: 0;
  }

  .pair-img {
    position: relative;
    align-self: stretch;
    min-height: 180px;
  }

  .pair-img img {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: contain;
    object-position: center;
  }

  /* Two images side by side inside the wrapper */
  .pair-img--double {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0.5rem;
  }

  .pair-img--double img {
    position: relative;
    inset: auto;
    width: 100%;
    height: 100%;
    object-fit: contain;
    object-position: center;
  }

  @media (max-width: 700px) {
    .pair {
      grid-template-columns: 1fr;
    }
    .pair.reverse > :first-child { order: 0; }
    .pair.reverse > :last-child  { order: 0; }
    .pair-img {
      min-height: 220px;
    }
  }
</style>
