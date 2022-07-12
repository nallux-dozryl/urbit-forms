<script>

  export let x, y, z
  export let req = false

</script>

{#if x.length > 0}
  <div class="essay">
    {#each x[0].split(/\r?\n/) as ln}
      <div class="ln">{ln}</div>
    {/each}
  </div>
{/if}


<style>

  .essay {
    padding-bottom: 1em;
    font-weight: 500;
  }

  .ln {
    font-size: .8em;
    color: #666;
    margin-bottom: 1em;
  }

</style>
