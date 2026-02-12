<script lang="ts">
  import Header from '$lib/Header.svelte';

  interface Veranstaltung {
    date: string;
    title: string;
    time: string;
    description: string;
    image: string;
  }

  const veranstaltungen: Veranstaltung[] = [
    {
      date: '2026-02-08',
      title: 'Frühjahrsputz am Parklet',
      time: '10:00 – 14:00',
      description: 'Gemeinsam machen wir das Parklet fit für die neue Saison. Wir streichen Holz, reparieren kleine Schäden und bepflanzen die Blumenkübel neu. Werkzeug und Farbe sind vorhanden — bring gerne Handschuhe mit!',
      image: '/B4.jpg'
    },
    {
      date: '2026-02-22',
      title: 'Nachbar*innen-Frühstück',
      time: '09:30 – 12:00',
      description: 'Unser erstes offenes Frühstück in diesem Jahr! Jede*r bringt etwas mit und wir teilen am großen Tisch. Kaffee und Tee stellen wir bereit. Eine gute Gelegenheit, neue Gesichter kennenzulernen.',
      image: '/B1.jpg'
    },
    {
      date: '2026-03-12',
      title: 'Pflanzentauschbörse',
      time: '14:00 – 17:00',
      description: 'Du hast zu viele Ableger? Oder suchst eine bestimmte Pflanze? Bei unserer Tauschbörse kannst Du Pflanzen, Samen und Stecklinge tauschen. Auch Tipps zur Pflege gibt es gratis dazu.',
      image: '/B5.jpg'
    },
    {
      date: '2026-03-26',
      title: 'Lesekreis auf dem Parklet',
      time: '16:00 – 18:00',
      description: 'Schnapp Dir ein Buch aus dem Tauschregal oder bring Dein eigenes mit. Wir lesen gemeinsam, tauschen uns über Gelesenes aus und genießen die Frühlingssonne auf dem Podest.',
      image: '/B2.jpg'
    },
    {
      date: '2026-04-10',
      title: 'Kreativ-Workshop: Upcycling',
      time: '11:00 – 15:00',
      description: 'Aus Alt mach Neu! In diesem Workshop gestalten wir gemeinsam nützliche Dinge aus Materialresten. Von Blumentöpfen aus Tetrapaks bis zu Sitzkissen aus alten Stoffen — der Kreativität sind keine Grenzen gesetzt.',
      image: '/B6.jpg'
    },
    {
      date: '2026-05-31',
      title: 'Akustik-Abend',
      time: '18:00 – 21:00',
      description: 'Ein gemütlicher Abend mit akustischer Musik auf dem Parklet. Lokale Musiker*innen spielen unplugged — nachbarschaftsfreundlich und unter freiem Himmel. Bringt Decken und gute Laune mit!',
      image: '/B7.jpg'
    },
    {
      date: '2026-06-14',
      title: 'Offenes Grillen',
      time: '17:00 – 21:00',
      description: 'Wir heizen den Grill an und laden die ganze Nachbar*innenschaft ein. Bringt mit, was auf den Rost soll. Salate, Brot und Getränke organisieren wir gemeinsam. Anmeldung über Instagram.',
      image: '/B3.jpg'
    },
    {
      date: '2026-07-05',
      title: 'Sommerflohmarkt',
      time: '10:00 – 16:00',
      description: 'Kleiner Flohmarkt rund ums Parklet. Trödel, Bücher, Kleidung, Spielzeug — alles was noch gut ist, aber ein neues Zuhause sucht. Standgebühr gibt es keine, nur gute Nachbar*innenschaft.',
      image: '/B1.jpg'
    }
  ];

  const WEEKDAYS = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
  const MONTH_NAMES = [
    'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
    'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'
  ];

  let currentMonth = $state(new Date().getMonth());
  let currentYear = $state(new Date().getFullYear());
  let selectedEvent = $state<Veranstaltung | null>(null);

  function getDaysInMonth(year: number, month: number): number {
    return new Date(year, month + 1, 0).getDate();
  }

  function getFirstWeekday(year: number, month: number): number {
    const day = new Date(year, month, 1).getDay();
    return day === 0 ? 6 : day - 1; // Monday = 0
  }

  function prevMonth() {
    if (currentMonth === 0) {
      currentMonth = 11;
      currentYear--;
    } else {
      currentMonth--;
    }
    selectedEvent = null;
  }

  function nextMonth() {
    if (currentMonth === 11) {
      currentMonth = 0;
      currentYear++;
    } else {
      currentMonth++;
    }
    selectedEvent = null;
  }

  function getEventsForDay(year: number, month: number, day: number): Veranstaltung[] {
    const dateStr = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    return veranstaltungen.filter(v => v.date === dateStr);
  }

  function formatDate(dateStr: string): string {
    const d = new Date(dateStr + 'T00:00:00');
    return `${d.getDate()}. ${MONTH_NAMES[d.getMonth()]} ${d.getFullYear()}`;
  }

  function isToday(year: number, month: number, day: number): boolean {
    const now = new Date();
    return now.getFullYear() === year && now.getMonth() === month && now.getDate() === day;
  }

  let eventDetailEl = $state<HTMLElement | null>(null);

  function selectEvent(event: Veranstaltung | null) {
    if (selectedEvent === event) {
      selectedEvent = null;
      return;
    }
    selectedEvent = event;
    if (event) {
      // Wait for the DOM to update, then scroll
      requestAnimationFrame(() => {
        eventDetailEl?.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    }
  }
</script>

<main>
  <Header />

  <section class="intro">
    <h1>Veran&shy;staltungen</h1>
    <div class="intro-text">
      <p class="tagline">Was passiert auf dem Parklet? Alle Termine auf einen Blick.</p>
    </div>
    <div class="intro-image">
      <img src="/B2.jpg" alt="Veranstaltungen auf dem Parklet" />
    </div>
  </section>

  <section class="content">
    {#if selectedEvent}
      <div class="event-detail" bind:this={eventDetailEl}>
        <div class="event-detail-content">
          <div class="event-detail-text">
            <h3>{selectedEvent.title}</h3>
            <p class="event-meta">{formatDate(selectedEvent.date)} · {selectedEvent.time}</p>
            <p>{selectedEvent.description}</p>
          </div>
          <div class="event-detail-image">
            <img src={selectedEvent.image} alt={selectedEvent.title} />
          </div>
        </div>
        <button class="close-btn" onclick={() => selectedEvent = null} aria-label="Schließen">&times;</button>
      </div>
    {/if}

    <div class="content-grid">
      <div class="calendar">
        <div class="calendar-header">
          <button class="nav-btn" onclick={prevMonth} aria-label="Vorheriger Monat">&larr;</button>
          <h2 class="calendar-title">{MONTH_NAMES[currentMonth]} {currentYear}</h2>
          <button class="nav-btn" onclick={nextMonth} aria-label="Nächster Monat">&rarr;</button>
        </div>

        <div class="calendar-weekdays">
          {#each WEEKDAYS as day}
            <div class="weekday">{day}</div>
          {/each}
        </div>

        <div class="calendar-grid">
          {#each Array(getFirstWeekday(currentYear, currentMonth)) as _}
            <div class="day empty"></div>
          {/each}

          {#each Array(getDaysInMonth(currentYear, currentMonth)) as _, i}
            {@const day = i + 1}
            {@const events = getEventsForDay(currentYear, currentMonth, day)}
            <button
              class="day"
              class:has-event={events.length > 0}
              class:today={isToday(currentYear, currentMonth, day)}
              class:selected={selectedEvent !== null && events.includes(selectedEvent)}
              onclick={() => { if (events.length > 0) selectEvent(events[0]); }}
              disabled={events.length === 0}
            >
              <span class="day-number">{day}</span>
              {#if events.length > 0}
                <span class="event-dot"></span>
              {/if}
            </button>
          {/each}
        </div>
      </div>

      <div class="upcoming">
        <h2>Kommende Termine</h2>
        {#each veranstaltungen as event}
          <button
            class="upcoming-item"
            class:active={selectedEvent === event}
            onclick={() => {
              const d = new Date(event.date + 'T00:00:00');
              currentMonth = d.getMonth();
              currentYear = d.getFullYear();
              selectEvent(event);
            }}
          >
            <div class="upcoming-date">
              <span class="upcoming-day">{new Date(event.date + 'T00:00:00').getDate()}</span>
              <span class="upcoming-month">{MONTH_NAMES[new Date(event.date + 'T00:00:00').getMonth()].slice(0, 3)}</span>
            </div>
            <div class="upcoming-info">
              <span class="upcoming-title">{event.title}</span>
              <span class="upcoming-time">{event.time}</span>
            </div>
          </button>
        {/each}
      </div>
    </div>
  </section>
</main>

<style>
  h1 {
    font-size: 2.5rem;
    line-height: 3rem;
  }

  @media (min-width: 1024px) {
    h1 {
      font-size: 3.75rem;
      line-height: 4rem;
    }
  }

  /* Content Grid */
  .content-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 2.5rem;
  }

  @media (min-width: 1024px) {
    .content-grid {
      grid-template-columns: 1fr 1fr;
      gap: 3rem;
      align-items: start;
    }
  }

  /* Calendar */
  .calendar {
    margin-bottom: 0;
  }

  .calendar-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1rem;
  }

  .calendar-title {
    font-size: 2rem;
    font-weight: 900;
    text-transform: uppercase;
    color: #000;
    margin: 0;
  }

  @media (min-width: 1024px) {
    .calendar-title {
      font-size: 2.5rem;
    }
  }

  .nav-btn {
    background: #000;
    color: #f0e4c9;
    border: none;
    width: 3rem;
    height: 3rem;
    font-size: 1.5rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
  }

  .nav-btn:hover {
    background: #333;
  }

  .calendar-weekdays {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 2px;
    margin-bottom: 2px;
  }

  .weekday {
    text-align: center;
    font-weight: 700;
    font-size: 0.875rem;
    text-transform: uppercase;
    padding: 0.5rem 0;
    color: #666;
  }

  .calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 2px;
  }

  .day {
    aspect-ratio: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: transparent;
    border: 2px solid transparent;
    cursor: default;
    position: relative;
    padding: 0;
    font-family: inherit;
    gap: 4px;
  }

  .day.empty {
    border: none;
  }

  .day-number {
    font-size: 1rem;
    font-weight: 600;
    color: #333;
  }

  @media (min-width: 640px) {
    .day-number {
      font-size: 1.125rem;
    }
  }

  .day.today {
    border-color: #333;
  }

  .day.today .day-number {
    font-weight: 900;
  }

  .day.has-event {
    cursor: pointer;
    background: #e8dbb8;
    border-color: #000;
  }

  .day.has-event:hover {
    background: #d4c89e;
  }

  .day.has-event.selected {
    background: #000;
  }

  .day.has-event.selected .day-number {
    color: #f0e4c9;
  }

  .day.has-event.selected .event-dot {
    background: #7954A2;
  }

  .event-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #7954A2;
  }

  /* Event Detail */
  .event-detail {
    position: relative;
    background: #000;
    color: #f0e4c9;
    padding: 2rem;
    margin-bottom: 2.5rem;
  }

  .event-detail-content {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }

  @media (min-width: 640px) {
    .event-detail-content {
      grid-template-columns: 1fr 1fr;
    }
  }

  .event-detail-text h3 {
    font-size: 1.75rem;
    font-weight: 900;
    text-transform: uppercase;
    margin: 0 0 0.5rem 0;
    color: #f0e4c9;
  }

  .event-meta {
    font-size: 1rem;
    font-weight: 700;
    color: #7954A2;
    margin: 0 0 1rem 0;
  }

  .event-detail-text p {
    font-size: 1.125rem;
    line-height: 1.75;
    margin: 0 0 1rem 0;
  }

  .event-detail-image img {
    width: 100%;
    height: auto;
    display: block;
  }

  .close-btn {
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: none;
    border: none;
    color: #f0e4c9;
    font-size: 2rem;
    cursor: pointer;
    line-height: 1;
    padding: 0;
    width: 2rem;
    height: 2rem;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .close-btn:hover {
    color: #fff;
  }

  /* Upcoming List */
  .upcoming {
    margin-bottom: 2.5rem;
  }

  .upcoming h2 {
    font-size: 2rem;
    font-weight: 900;
    text-transform: uppercase;
    color: #000;
    margin: 0 0 1.5rem 0;
  }

  @media (min-width: 1024px) {
    .upcoming h2 {
      font-size: 2.5rem;
    }
  }

  .upcoming-item {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 1rem 0;
    border-top: 2px solid #000;
    cursor: pointer;
    width: 100%;
    background: none;
    border-left: none;
    border-right: none;
    border-bottom: none;
    text-align: left;
    font-family: inherit;
  }

  .upcoming-item:last-child {
    border-bottom: 2px solid #000;
  }

  .upcoming-item:hover {
    background: #e8dbb8;
  }

  .upcoming-item.active {
    background: #000;
    padding: 1rem;
  }

  .upcoming-item.active .upcoming-day,
  .upcoming-item.active .upcoming-month,
  .upcoming-item.active .upcoming-title,
  .upcoming-item.active .upcoming-time {
    color: #f0e4c9;
  }

  .upcoming-date {
    display: flex;
    flex-direction: column;
    align-items: center;
    min-width: 3.5rem;
  }

  .upcoming-day {
    font-size: 1.75rem;
    font-weight: 900;
    color: #000;
    line-height: 1;
  }

  .upcoming-month {
    font-size: 0.875rem;
    font-weight: 700;
    text-transform: uppercase;
    color: #666;
  }

  .upcoming-info {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
  }

  .upcoming-title {
    font-size: 1.125rem;
    font-weight: 700;
    color: #000;
  }

  .upcoming-time {
    font-size: 0.875rem;
    color: #666;
  }
</style>
