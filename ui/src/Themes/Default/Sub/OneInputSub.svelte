<script>

  import NotAnswered from './NotAnswered.svelte'
  import { afterUpdate } from 'svelte'

  export let info, q

  let selected = []

  afterUpdate(()=> {
    handleSel()  
  })


  function handleSel() {
    selected = []
    if (info.a.length > 0) {
      selected = info.a  
    }
  }

  handleSel()

</script>

{#if (info.a[0] === undefined)}
  <NotAnswered />
{:else if q.y.length > 0}
  {#each q.y as oy, j}
    <div class="row">
      <div class="label">{oy}</div>
      {#each q.x as o}
        <button
          class="option {selected[j] === o ? "active" : ""}"
          disabled
        >
          {o}
        </button>
      {/each}
    </div>
  {/each}
{:else}
  {#if q.x.length > 0}
    <div class="row">
      {#each q.x as o}
        <button 
          class="option {selected[0] === o ? "active" : ""}"
          disabled
        >
          {o}
        </button>
      {/each}
    </div>
  {/if}
{/if}

<style>

  .row {
    display: flex;
    gap: 1em;
    align-items: center;
    margin-bottom: 2em; 
  }

  .label {
    font-size: .8em;
    font-weight: 500;
    color: #666;
  }

  .option {
    flex: 2;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    padding: 1em;
    background: white;
  }

  .active:disabled {
    background: black;
    border-color: black;
    color: white;
  }

  .active:hover {
    background: black;
    border-color: black;
  }

</style>
