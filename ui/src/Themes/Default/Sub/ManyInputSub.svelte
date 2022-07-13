<script>

  import NotAnswered from './NotAnswered.svelte'
  import { afterUpdate } from 'svelte'

  export let info, q

  let checkedStates = [];

  $: checked = q.x.filter((_, i) => checkedStates[i]);

  let gridChecked = []

  afterUpdate(()=> {
    handleChecks()  
  })

  function handleChecks() {
    checkedStates = []
    if (q.accept === "grid") { 
      for (let i = 0; i < q.y.length; i++) {
        checkedStates.push({ y: q.y[i], x: []})
      
        const exes = []
        for (let w = 0; w < info.b.length; w++) {
          if (info.b[w].y === q.y[i]) {
            exes.push(info.b[w].x)
          }
        }
        for (let h = 0; h < q.x.length; h++) {
          if (exes.includes(q.x[h])) {
            checkedStates[i].x.push(true)
          } else {
            checkedStates[i].x.push(false)
          }
        }
      }
    }
    if (q.accept === "list") {
      for (let g = 0; g < q.x.length; g++) {
          if (info.a.includes(q.x[g])) {
              checkedStates.push(true)
          } else {
              checkedStates.push(false)
          }
      }
    }
  }
    
  handleChecks()

</script>
{#if (info.a[0] === undefined) && (info.b[0] === undefined)}
  <NotAnswered />
{:else if q.y.length > 0}
  <div class="container">
    <div class="header">
      <div class="col"></div>
      {#each q.x as ox, j}
        <div class="col">{ox}</div>
      {/each}
    </div>
    {#each q.y as oy, m}
      <div class="entry">
        <div class="loc">{oy}</div>
        {#each q.x as ox, n}
          <div class="col">
            <input
              class="loc"
              type="checkbox"
              name={ox}
              bind:checked={checkedStates[m].x[n]}
            />
          </div>
        {/each}
      </div>
    {/each}
  </div>
{:else}
  <div class="container">
    {#each q.x as o, j}
      <div class="option">
          <input 
            type="checkbox" 
            name={o}
            bind:checked={checkedStates[j]}
          />
        <div class="text">{o}</div>
      </div>
    {/each}
    <!--
    {#if (prompt && (q.min === q.max)) && (0 < q.min + q.max)}
      Pick {q.max} options
    {:else if prompt && (q.min > checked.length)}
      <div class="prompt">
        Pick {q.min} to {q.max} options
      </div>
    {:else if prompt && (q.max > checked.length)}
      <div class="prompt">
        Pick up to {q.max - checked.length} more option{q.max - checked.length > 1 ? "s" : ""}
      </div> 
    {/if}
    -->
  </div>
{/if}




<style>

  .header {
    display: flex;
    margin-bottom: 1em;
    font-size: .8em;
    font-weight: 500;
  }

  .entry {
    display: flex;
    align-items: center;
  }

  .col {
    flex: 1;
    text-align: center;
  }

  .loc {
    text-align: center;
    flex: 1;
    padding: .6em 0 .6em 0;
    font-size: .8em;
    font-weight: 500;
    margin-bottom: .6em;
  }

  .container {
    margin-bottom: 2em;
  }

  .option {
    display: flex;
    margin-bottom: 1em;
  }

  .prompt {
    margin-bottom: 1em;
    font-size: .8em;
    font-weight: 500;
  }

  input[type=checkbox] {
    appearance: none;
    background-color: #e9e9e9;
    margin: 0;
    font: inherit;
    width: 1.3em;
    height: 1.3em;
    border-radius: 4px;
  }

  input[type=checkbox]:checked {
    background-color: black;
  }

  input[type=checkbox]:disabled {
    background-color: #f2f2f2;
  }

  input[type=checkbox]:hover {
    background-color: #666;
  }

  .text {
    padding-left: .6em;
    font-weight: 300;
  }

</style>
