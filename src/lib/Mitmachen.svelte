<script lang="ts">
  import Header from '$lib/Header.svelte';
</script>

<main>
  <Header />

  <section class="intro">
    <div class="intro-text">
      <h1>Mit&shy;machen</h1>
      <p class="tagline">Werde Teil unserer Nachbar*innenschaft und gestalte den öffentlichen Raum mit.</p>
    </div>
    <div class="intro-image">
      <img src="/B1.jpg" alt="Mitmachen beim Parklet" />
    </div>
  </section>

  <section class="content">
    <div class="block">
      <h2>Werde aktiv</h2>
      <p>
        Unser Parklet lebt von den Menschen, die es nutzen, pflegen und mitgestalten.
        Ob Du regelmäßig vorbeischauen möchtest, bei Veranstaltungen mithelfen willst
        oder eigene Ideen einbringen möchtest — es gibt viele Wege, Teil unserer
        Gemeinschaft zu werden.
      </p>
      <p>
        Du musst kein Profi sein. Was zählt, ist die Lust, gemeinsam etwas für unser
        Viertel zu bewegen. Jede helfende Hand macht einen Unterschied.
      </p>
    </div>

    <div class="image-row">
      <img src="/B4.jpg" alt="Gemeinschaft am Parklet" />
      <img src="/B6.jpg" alt="Nachbarschaft im Austausch" />
    </div>

    <div class="block">
      <h2>Wie Du helfen kannst</h2>
      <p class="subheading">Pflege und Gießen</p>
      <p>
        Unsere Pflanzen brauchen regelmäßig Wasser und Aufmerksamkeit. Besonders in den
        Sommermonaten freuen wir uns über Gießpat*innen, die ab und zu vorbeikommen und
        den Blumenkübeln und Stauden etwas Gutes tun.
      </p>
      <p class="subheading">Aufräumen und Sauberhalten</p>
      <p>
        Ein gepflegtes Parklet lädt zum Verweilen ein. Wenn Du mal vorbeischaust und etwas
        aufräumst oder den Müll entsorgst, hilfst Du uns enorm. Kleine Gesten, große Wirkung.
      </p>
      <p class="subheading">Reparaturen und Handwerk</p>
      <p>
        Wind, Wetter und Nutzung hinterlassen Spuren. Wer handwerklich geschickt ist und
        Lust hat, bei kleinen Reparaturen oder Verbesserungen mitzuwirken, ist herzlich
        willkommen.
      </p>
    </div>

    <div class="image-full">
      <img src="/B5.jpg" alt="Parklet Begrünung und Pflege" />
    </div>

    <div class="block">
      <h2>Veranstaltungen</h2>
      <p>
        Das Parklet ist mehr als Holz und Pflanzen — es ist ein Treffpunkt. Wir organisieren
        regelmäßig kleine Veranstaltungen und Nachbar*innenschaftstreffen auf der Fläche.
        Du hast eine Idee für ein Event? Dann melde Dich bei uns!
      </p>
      <ul>
        <li>Gemeinsames Frühstück oder Abendessen auf dem Parklet</li>
        <li>Tauschbörsen für Bücher, Pflanzen oder Kleidung</li>
        <li>Kreativ-Workshops: Malen, Basteln, Upcycling</li>
        <li>Offene Gesprächsrunden zu Themen rund ums Viertel</li>
        <li>Musik und Kultur — akustisch und nachbarschaftsfreundlich</li>
      </ul>
    </div>

    <div class="image-row">
      <img src="/B2.jpg" alt="Veranstaltung am Parklet" />
      <img src="/B7.jpg" alt="Leben auf dem Parklet" />
    </div>

    <div class="block">
      <h2>Eigene Ideen einbringen</h2>
      <p>
        Der öffentliche Raum gehört uns allen. Wenn Du eine Idee hast, wie wir das Parklet
        noch besser machen können — sei es eine neue Bepflanzung, ein Gestaltungsvorschlag
        oder ein Veranstaltungsformat — dann sprich uns einfach an. Wir sind offen für alles,
        was einen Mehrwert für die Nachbar*innenschaft schafft.
      </p>
      <p>
        Grundsätzlich gilt: Das Parklet ist öffentlich zugänglich, nicht kommerziell und für alle da.
        Die Nachtruhe zwischen 22:00 und 06:00 Uhr ist zu beachten.
      </p>
    </div>

    <div class="image-full">
      <img src="/B3.jpg" alt="Das Parklet in der Katharinenstraße" />
    </div>

    <div class="block">
      <h2>Kontakt</h2>
      <p>
        Am einfachsten erreichst Du uns über unseren Instagram-Account. Dort posten wir
        auch Neuigkeiten, Termine und Fotos vom Parklet-Leben. Oder komm einfach vorbei —
        wir freuen uns auf Dich!
      </p>
      <p>
        Du findest uns in der Katharinenstraße im Leonhardsviertel, Stuttgart.
      </p>
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

  /* Intro / Hero */
  .intro {
    display: grid;
    grid-template-columns: 1fr;
    max-width: 1200px;
    margin: 0 auto;
    padding: 1rem;
  }

  @media (min-width: 1024px) {
    .intro {
      grid-template-columns: 1fr 2fr;
      padding: 2.5rem 1rem;
    }
  }

  .intro-text {
    order: 2;
    margin-top: 2rem;
  }

  @media (min-width: 1024px) {
    .intro-text {
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

  .intro-image {
    order: 1;
  }

  @media (min-width: 1024px) {
    .intro-image {
      order: 0;
    }
  }

  .intro-image img {
    width: 100%;
    height: auto;
    display: block;
  }

  /* Content */
  .content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1rem;
  }

  .block {
    margin-bottom: 2.5rem;
  }

  h2 {
    font-size: 2rem;
    font-weight: 900;
    text-transform: uppercase;
    color: #000;
    margin: 0 0 1rem 0;
  }

  @media (min-width: 1024px) {
    h2 {
      font-size: 2.5rem;
    }
  }

  p {
    font-size: 1.125rem;
    line-height: 1.75;
    margin: 0 0 1rem 0;
  }

  .subheading {
    font-weight: 700;
  }

  ul {
    padding-left: 1.5rem;
    margin: 0 0 1rem 0;
  }

  li {
    font-size: 1.125rem;
    line-height: 1.75;
    margin-bottom: 0.5rem;
  }

  /* Images */
  .image-row {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1rem;
    margin-bottom: 2.5rem;
  }

  @media (min-width: 640px) {
    .image-row {
      grid-template-columns: 1fr 1fr;
    }
  }

  .image-row img {
    width: 100%;
    height: 300px;
    object-fit: cover;
    display: block;
  }

  .image-full {
    margin-bottom: 2.5rem;
  }

  .image-full img {
    width: 100%;
    height: auto;
    max-height: 500px;
    object-fit: cover;
    display: block;
  }
</style>
