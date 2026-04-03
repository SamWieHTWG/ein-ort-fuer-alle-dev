<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<main>
  <Header />

  <section class="intro">
    <div class="intro-text">
      <h1>Mit&shy;machen</h1>
      <p class="tagline">Die Nachbarschaft ist eingeladen, sich am Aufbau, an der Gestaltung und an der Nutzung zu beteiligen.</p>
    </div>
    <div class="intro-image">
      <img src="/B1.jpg" alt="Mitmachen beim Parklet" />
    </div>
  </section>

  <section class="content">

    <div class="pair">
      <div class="block">
        <h2>Gemeinsam gestalten</h2>
        <p>
          Das Parklet ist ein Nachbarschaftsprojekt — getragen von Menschen aus dem Viertel, für
          Menschen aus dem Viertel. Jede*r ist eingeladen mitzumachen: beim Aufbau, bei der
          Gestaltung oder einfach durch die Nutzung.
        </p>
        <p>
          Ein Ort entsteht erst dann wirklich, wenn ihn alle mitgestalten und sich gemeinsam dafür
          verantwortlich fühlen.
        </p>
      </div>
      <div class="pair-images">
        <img src="/B4.jpg" alt="Gemeinschaft am Parklet" />
        <img src="/B6.jpg" alt="Nachbarschaft im Austausch" />
      </div>
    </div>

    <div class="pair reverse">
      <div class="block">
        <h2>Mögliche Aktivitäten</h2>
        <p>
          Das Parklet soll als offener Aufenthaltsort dienen — zum Sitzen, Liegen, Austauschen,
          Lesen oder einfach zum Verweilen. Mögliche Aktivitäten sind:
        </p>
        <ul>
          <li>Gemeinsame Nachbar*innenschaftsessen</li>
          <li>Bastelnachmittage und kreative Formate</li>
          <li>Spontaner Austausch zwischen Bewohner*innen und Passant*innen</li>
          <li>Alltägliches Zusammensitzen im öffentlichen Raum</li>
        </ul>
        <p>Du hast eine Idee? Dann melde dich bei uns!</p>
      </div>
      <img src="/B5.jpg" alt="Parklet Begrünung und Pflege" />
    </div>

    <div class="pair">
      <div class="block">
        <h2>Pflege</h2>
        <p>
          Reinigung, Pflanzenpflege, kleine Reparaturen — das alles regeln wir gemeinsam. Wer
          Lust hat, mitzuhelfen, ist herzlich willkommen.
        </p>
      </div>
      <div class="pair-images">
        <img src="/B2.jpg" alt="Veranstaltung am Parklet" />
        <img src="/B7.jpg" alt="Leben auf dem Parklet" />
      </div>
    </div>

  </section>
</main>

<style>
  .pair {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 2.5rem;
    align-items: start;
    margin-bottom: 3rem;
  }

  .pair.reverse > :first-child { order: 2; }
  .pair.reverse > :last-child  { order: 1; }

  .pair > img,
  .pair-images img {
    width: 100%;
    height: 240px;
    object-fit: cover;
    display: block;
  }

  .pair-images {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0.5rem;
    align-self: start;
  }

  @media (max-width: 700px) {
    .pair {
      grid-template-columns: 1fr;
    }
    .pair.reverse > :first-child { order: 0; }
    .pair.reverse > :last-child  { order: 0; }
  }
</style>
