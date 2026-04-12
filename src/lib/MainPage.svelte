<script lang="ts">
  import Header from '$lib/Header.svelte';
  import Bubble from '$lib/Bubble.svelte';
  import { COLOR_PRIMARY, COLOR_SECONDARY } from '$lib/constants';
</script>

<Header />

<div class="content-border"></div>
<main>
  <section class="content">
    <div class="pair">
      <div class="block block--primary">
        <p class="greeting">Liebe Nachbar*innen und Lehen-Fans,</p>
        <p>wir möchten gemeinsam mit euch einen weiteren <strong>Begegnungsort im Viertel</strong> schaffen: ein <strong>Parklet</strong> – ein Platz zum Sitzen, Austauschen, Essen, Lesen, Spielen und Sonne genießen.</p>
        <p>Viele Menschen haben keinen Balkon – gleichzeitig gibt es nur wenige nicht-kommerzielle Orte, an denen Menschen einfach draußen zusammensitzen können.</p>
        <p>Glücklicherweise können wir ein altes Parklet mit großem Sitzbereich und bequemer Liege übernehmen – nun wollen wir es <strong>gemeinsam reparieren, neu gestalten und wieder aufbauen</strong> (am liebsten unter der großen Linde in der Alexanderstrasse).</p>
        <p>Dafür brauchen wir eure <strong>Unterstützung und Hilfe:</strong></p>
        <p>Das Parklet soll ein offener Ort für die Nachbar*innenschaft werden – und lebt davon, dass viele Menschen sich beteiligen.</p>
        <p>Wenn du Lust hast mitzumachen oder einfach neugierig bist, <a href="/kontakt">melde dich gerne!</a></p>
      </div>
      <div class="pair-right">
        <div class="pair-img">
          <img src="/anlehnen/satelliet.jpeg" alt="Standort Alexanderstrasse" />
        </div>
        <div class="bubble-area">
          <Bubble href="/mitmachen" label="Mitmachen" color={COLOR_SECONDARY} hoverColor={COLOR_PRIMARY} textColor={COLOR_PRIMARY} hoverTextColor={COLOR_SECONDARY} zIndex={12} />
          <Bubble href="/unser-parklet" label={"Unser\nParklet"} color={COLOR_SECONDARY} hoverColor={COLOR_PRIMARY} textColor={COLOR_PRIMARY} hoverTextColor={COLOR_SECONDARY} zIndex={11} />
          <Bubble href="/kontakt" label="Kontakt" color={COLOR_SECONDARY} hoverColor={COLOR_PRIMARY} textColor={COLOR_PRIMARY} hoverTextColor={COLOR_SECONDARY} zIndex={10} />
        </div>
      </div>
    </div>
  </section>
</main>

<style>
  .greeting {
    font-weight: 700;
  }

  .pair {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 2.5rem;
    align-items: stretch;
  }

  .pair .block {
    margin-bottom: 0;
  }

  .pair-right {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: 1.5rem;
  }

  .pair-img img {
    width: 100%;
    height: auto;
    display: block;
  }

  .bubble-area {
    position: relative;
    min-height: 220px;
  }

  @media (max-width: 700px) {
    .pair {
      grid-template-columns: 1fr;
    }
  }
</style>
