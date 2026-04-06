<script lang="ts">
  import Header from '$lib/Header.svelte';
  import LogoAnimation from '$lib/LogoAnimation.svelte';
  import Bubble from '$lib/Bubble.svelte';
  import { COLOR_PRIMARY, COLOR_SECONDARY } from '$lib/constants';
</script>

<main>
  <Header />

  <!-- <LogoAnimation /> -->

  <section class="intro">
    <div class="intro-text">
      <!-- <h1>Ein Ort für ALLE</h1> -->
      <p class="tagline">Sitzen, austauschen, verweilen – ein offener, nicht-kommerzieller Treffpunkt für die Nachbar*innenschaft im Lehenviertel.</p>
    </div>
    <div class="bubble-area">
      <Bubble href="/mitmachen" label="Mitmachen" color={COLOR_SECONDARY} hoverColor={COLOR_PRIMARY} zIndex={12} />
      <Bubble href="/unser-parklet" label={"Unser\nParklet"} color={COLOR_PRIMARY} hoverColor={COLOR_SECONDARY} zIndex={11} />
      <Bubble href="/kontakt" label="Kontakt" color={COLOR_PRIMARY} hoverColor={COLOR_SECONDARY} zIndex={10} />
    </div>
  </section>
</main>
