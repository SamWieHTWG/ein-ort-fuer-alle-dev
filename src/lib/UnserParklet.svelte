<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<main>
  <Header />

  <section class="intro intro--full">
    <div class="intro-text">
      <h1>Unser Parklet</h1>
      <p class="tagline">Ein offener, nicht-kommerzieller Begegnungsort für die Nachbar*innenschaft im Lehenviertel.</p>
    </div>
  </section>

  <section class="content">

    <div class="pair">
      <div class="block block--primary">
        <h2>Was ist ein Parklet?</h2>
        <p>
          Parklets sind temporäre Erweiterungen des öffentlichen Raums, die auf der Fläche eines oder
          zweier Parkplätze entstehen. Sie verwandeln einen kleinen Teil der Straße in einen Ort für
          Aufenthalt, Begegnung und gemeinschaftliche Nutzung.
        </p>
        <p>
          Parklets stehen allen Menschen frei zur Verfügung — mit Sitzgelegenheiten, Pflanzen,
          Tischen oder Liegeflächen. Eine gewerbliche Nutzung findet nicht statt.
        </p>
      </div>
      <div class="pair-images">
        <img src="/B1.jpg" alt="Parklet Impression" />
      </div>
    </div>

    <div class="pair reverse">
      <div class="block block--secondary">
        <h2>Das Parklet</h2>
        <p>
          Unser Parklet hat in der Katharinenstraße bereits einige Jahre gelebt — als Ort für
          Begegnung, gemeinsames Essen, kleine Workshops und spontanen Austausch. Jetzt bekommt
          es einen neuen Platz in der Alexanderstraße.
        </p>
        <p class="subheading">Was euch erwartet:</p>
        <ul>
          <li>Liege- und Sitzfläche zum Entspannen</li>
          <li>Großer Tisch für gemeinsame Essen und Veranstaltungen</li>
          <li>Modulare Sitzbänke</li>
          <li>Begrünung durch integrierte Pflanzkübel</li>
          <li>Sonnenschutz durch ein Tarp</li>
        </ul>
      </div>
      <img src="/B2.jpg" alt="Parklet Begrünung" />
    </div>

    <div class="pair">
      <div class="block block--primary">
        <h2>Warum ein Parklet im Lehenviertel?</h2>
        <p>
          Das Lehenviertel ist ein lebendiges, dicht besiedeltes Stadtviertel — mit vielen Menschen,
          aber nur wenigen Orten im Freien, an denen man einfach verweilen kann. Ein eigener Balkon
          oder Garten ist hier nicht selbstverständlich.
        </p>
        <p>Das Parklet soll diese Lücke schließen: ein Ort für alle, kostenlos, ohne Konsumzwang.</p>
        <ul>
          <li>Frei zugänglich und nicht-kommerziell</li>
          <li>Treffpunkt für Nachbar*innen</li>
          <li>Raum für gemeinsame Aktivitäten und spontane Begegnungen</li>
          <li>Mehr Grün und Aufenthaltsqualität im Straßenraum</li>
        </ul>
      </div>
      <div class="pair-images">
        <img src="/B6.jpg" alt="Parklet Nachbarschaft" />
      </div>
    </div>

    <div class="pair reverse">
      <div class="block block--secondary">
        <h2>Der Standort</h2>
        <p>
          Das Parklet entsteht in der Alexanderstraße im Lehenviertel — mitten im Viertel, gut
          erreichbar für alle. Ein Ort, an dem man einfach vorbeikommen, bleiben und ins Gespräch
          kommen kann.
        </p>
      </div>
      <img src="/B7.jpg" alt="Parklet im Viertel" />
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

  .pair > img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    object-position: center;
    display: block;
  }

  .pair-images {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0.5rem;
    align-items: stretch;
  }

  .pair-images img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    object-position: center;
    display: block;
  }

  @media (max-width: 700px) {
    .pair {
      grid-template-columns: 1fr;
    }
    .pair.reverse > :first-child { order: 0; }
    .pair.reverse > :last-child  { order: 0; }
    .pair > img,
    .pair-images img {
      height: auto;
    }
  }
</style>
