<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<Header />

<div class="content-border"></div>
<main>
  <section class="intro intro--full">
    <div class="intro-text block--secondary">
      <h1>Unser Parklet</h1>
      <p class="tagline">Ein Parkplatz weniger, ein Platz zum Anlehnen mehr — mitten im Lehenviertel.</p>
    </div>
  </section>

  <section class="content">

    <div class="pair">
      <div class="block block--primary">
        <h2>Was ist ein Parklet?</h2>
        <p>
          Ein Parklet ist eine kleine Erweiterung des öffentlichen Raums:
          Ein Parkplatz wird zu einem Mini-Platz für Menschen statt für Autos.
        </p>
        <p>
          Parklets stehen allen Menschen frei zur Verfügung — mit Sitzgelegenheiten, Pflanzen,
          Tischen oder Liegeflächen. Eine gewerbliche Nutzung findet nicht statt.
        </p>
      </div>
      <div class="pair-img">
        <img src="/B1.jpg" alt="Parklet Impression" />
      </div>
    </div>

    <div class="pair reverse">
      <div class="block block--secondary">
        <h2>Das Parklet</h2>
        <p>
          Wir haben die Möglichkeit, ein bestehendes Parklet aus der Katharinenstraße zu übernehmen
          und gemeinsam weiterzuentwickeln. Jetzt möchten wir es gemeinsam aufbauen, reparieren und
          neu gestalten.
        </p>
        <p class="subheading">Es gibt bereits:</p>
        <ul>
          <li>Eine bequeme Liegefläche</li>
          <li>Einen großen Tisch mit Sitzbereich</li>
          <li>Modulare Bänke</li>
          <li>Pflanzkübel</li>
          <li>Ein Sonnensegel</li>
        </ul>
      </div>
      <div class="pair-img">
        <img src="/B2.jpg" alt="Parklet Begrünung" />
      </div>
    </div>

    <div class="pair">
      <div class="block block--primary">
        <h2>Was wir uns wünschen</h2>
        <p>
          Viele Menschen im Viertel haben keinen Balkon oder Garten. Gleichzeitig gibt es nur wenige
          nicht-kommerzielle Orte, an denen Menschen einfach draußen zusammensitzen können.
          Mit ANLEHNEN möchten wir einen Treffpunkt für alle schaffen.
        </p>
        <p>Ein Ort ...</p>
        <ul>
          <li>für Begegnung und Austausch in der Nachbar*innenschaft</li>
          <li>zum gemeinsam Essen, Basteln und Entspannen</li>
          <li>zum Spielen für Kinder, Gespräche, kleine Workshops und spontane Treffen</li>
          <li>der mehr Grün in die Straße bringt</li>
          <li>an dem man erfährt: Wer wohnt eigentlich nebenan?</li>
        </ul>
      </div>
      <div class="pair-img">
        <img src="/B6.jpg" alt="Parklet Nachbarschaft" />
      </div>
    </div>

    <div class="pair reverse">
      <div class="block block--secondary">
        <h2>Der Standort</h2>
        <p>
          Am liebsten unter der großen Linde in der Alexanderstraße — mitten im Viertel, gut
          erreichbar für alle. Ein Ort, an dem man einfach vorbeikommen, bleiben und ins Gespräch
          kommen kann.
        </p>
      </div>
      <div class="pair-img">
        <img src="/B7.jpg" alt="Parklet im Viertel" />
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
