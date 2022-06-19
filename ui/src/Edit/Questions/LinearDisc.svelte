<script>
  import { createEventDispatcher } from 'svelte'
  export let qs;

  let min = 0;
  let max = 100;

  const dispatch = createEventDispatcher();

  function handleUpdate() {
      qs.x = [min.toString()]
      qs.y = [max.toString()]
      dispatch('update', null)
    }

</script>


<div class="container">
  <div class="min">
    <span>min</span>
    <input 
      type="number" 
      bind:value={min} 
      on:blur={handleUpdate}
    />
  </div>
  <div class="max">
    <span>max</span>
    <input 
      type="number" 
      bind:value={max} 
      on:blur={handleUpdate}
    />
  </div>
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
