<script>
    import { createEventDispatcher } from 'svelte';
    import { active } from '../UrbitStore';

    const dispatch = createEventDispatcher();
    function addOption() {
        dispatch('update', null)  
    }
    export let x;

</script>
{#each x as sel, i}
  <div class="one">
    <div class="dot">
      <input type="radio" disabled />
    </div>
    <input
      class="choice" 
      type="text" 
      bind:value={x[i]} 
      placeholder="nothing here"  
      on:blur={addOption}
    />
  </div>
{/each}
<div class="one">
  <div class="dot">
    <input type="radio" disabled />
  </div>
  <button 
    class="new" 
    on:click={()=> x.push("")}
  >
    Add Option
  </button>
</div>

<style>

  .dot {
    flex: 1;
    padding: .3em .2em 0.2em;
  }
  
  .choice {
    flex: 19;
    margin: auto;
  }

  .one {
    display: flex;
  }

  button {
    border: 1px solid black;
    background: white;
    padding: .3em;
    text-align: left;
  }

  button:hover {
    background: black;
    color: white;
  }

  .new {
    flex: 19;
    margin: auto;
  }

</style>
