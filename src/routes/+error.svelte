<script lang="ts">
  import { page } from '$app/stores';
</script>

<div class="error-container">
  <h1>{$page.status}</h1>
  <p>{$page.error?.message || 'An error occurred'}</p>
  <a href="/">Go back home</a>
</div>

<style>
  .error-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 60vh;
    text-align: center;
    padding: 2rem;
  }

  h1 {
    font-size: 4rem;
    color: #ff3e00;
    margin-bottom: 1rem;
  }

  p {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 2rem;
  }

  a {
    color: #ff3e00;
    text-decoration: none;
  }

  a:hover {
    text-decoration: underline;
  }
</style>
