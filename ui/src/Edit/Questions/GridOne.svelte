<script>
  import { createEventDispatcher } from 'svelte'
  export let qs;

  const dispatch = createEventDispatcher();

  function handleX() {
      qs.x.push("")
      dispatch('update', null)
    }

  function handleY() {
      qs.y.push("")
      dispatch('update', null)
    }

  function deleteX(i) {
      qs.x.splice(i, 1)
      dispatch('update', null)
    }

  function deleteY(i) {
      qs.y.splice(i, 1)
      dispatch('update', null)
    }

</script>


<div class="container">
  <div class="line">
    <span>Rows</span>
    {#if qs.y}
      {#each qs.y as oy, i}
        <div class="option">
          <input 
            type="text" 
            on:blur={()=> dispatch('update', null)}
            bind:value={qs.y[i]}
          />
          <button on:click={()=> deleteY(i)}>x</button>
        </div>
      {/each}
      <button on:click={handleY}>Add Option</button>
    {/if}
  </div>
  <div class="line">
    <span>Columns</span>
    {#if qs.x}
      {#each qs.x as ox, i}
        <div class="option">
          <input 
            type="text" 
            on:blur={()=> dispatch('update', null)}
            bind:value={qs.x[i]}
          />
          <button on:click={()=> deleteX(i)}>x</button>
        </div>
      {/each}
      <button on:click={handleX}>Add Option</button>
    {/if}
  </div>
</div>

<style>

  .container {
    display: flex;
    align-items: flex-start;
  }

  .line {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: .6em;
  }

  .option {
    flex: 1;
  }

</style>
