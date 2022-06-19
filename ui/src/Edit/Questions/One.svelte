<script>
  import { createEventDispatcher } from 'svelte'
  export let qs;

  const dispatch = createEventDispatcher();

  function handleClick() {
      qs.x.push("")
      dispatch('update', null)
    }

  function deleteOption(i) {
      qs.x.splice(i, 1)
      dispatch('update', null)
    }
</script>


<div class="container">
  {#if qs.x}
    {#each qs.x as ox, i}
      <div class="option">
        <input type="radio" disabled />
        <input 
          type="text" 
          on:blur={()=> dispatch('update', null)} 
          bind:value={qs.x[i]} 
        />
        <button on:click={()=> deleteOption(i)}>x</button>
      </div>
    {/each}
  {/if}
  <button on:click={handleClick}>Add Option</button>
</div>

<style>

  .container {
    display: flex;
    flex-direction: column;
  }

  .option {
    flex: 1;
  }

</style>
