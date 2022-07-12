<script>

  $: innerWidth = 0

</script>

<svelte:window bind:innerWidth />

{#if innerWidth >= 960 / 9 * 10}
  <div class="half">
    <slot />
  </div>
{:else}
  <div class="full">
    <slot />
  </div>
{/if}

<style>

  .half {
    width: 960px;
    margin: auto;
  }

  .full {
    width: 90%;
    margin: auto;
  }

</style>
