<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<main>
  <Header />

  <section class="intro">
    <div class="intro-text">
      <h1>Mit&shy;machen</h1>
      <p class="tagline">Die Nachbarschaft ist ausdrücklich eingeladen, sich am Aufbau, an der Gestaltung und an der Nutzung zu beteiligen.</p>
    </div>
    <div class="intro-image">
      <img src="/B1.jpg" alt="Mitmachen beim Parklet" />
    </div>
  </section>

  <section class="content">
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

    <div class="image-row">
      <img src="/B4.jpg" alt="Gemeinschaft am Parklet" />
      <img src="/B6.jpg" alt="Nachbarschaft im Austausch" />
    </div>

    <div class="block">
      <h2>Mögliche Aktivitäten</h2>
      <p>
        Das Parklet soll als offener Aufenthaltsort dienen — zum Sitzen, Liegen, Austauschen, Lesen
        oder einfach zum Verweilen im öffentlichen Raum. Mögliche Aktivitäten sind:
      </p>
      <ul>
        <li>Gemeinsame Nachbar*innenschaftsessen</li>
        <li>Bastelnachmittage und kreative Formate</li>
        <li>Spontaner Austausch zwischen Bewohner*innen und Passant*innen</li>
        <li>Alltägliches Zusammensitzen im öffentlichen Raum</li>
      </ul>
      <p>Du hast eine Idee? Dann melde Dich bei uns!</p>
    </div>

    <div class="image-full">
      <img src="/B5.jpg" alt="Parklet Begrünung und Pflege" />
    </div>

    <div class="block">
      <h2>Pflege</h2>
      <p>
        Reinigung, Pflanzenpflege, kleine Reparaturen — das alles regeln wir gemeinsam. Wer
        Lust hat, mitzuhelfen, ist herzlich willkommen.
      </p>
    </div>

    <div class="image-row">
      <img src="/B2.jpg" alt="Veranstaltung am Parklet" />
      <img src="/B7.jpg" alt="Leben auf dem Parklet" />
    </div>
  </section>
</main>

<style>
  .image-row {
    max-width: 50%;
  }

  .image-full img {
    max-width: 50%;
  }
</style>
