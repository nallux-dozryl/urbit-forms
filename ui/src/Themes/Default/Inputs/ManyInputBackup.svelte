<script>

  import { active, editDraft } from '/src/UrbitStore'

    export let n, i

  let checkedStates = [];
  let disabled = false;
  let prompt = true;

  if ($active[1][n].sec[i].accept === "grid") {
      for (let i = 0; i < $active[1][n].sec[i].y.length; i++) {
        checkedStates.push({ y: $active[1][n].sec[i].y[i], x: []})
        for (let j = 0; j < $active[1][n].sec[i].x.length; j++) {
          checkedStates[i].x.push(false)
        }
      }
    
    } else if ($active[1][n].sec[i].accept === "list") {
        for (let i = 0; i < $active[1][n].sec[i].x.length; i++) {
       //if (q.answer.includes(q.x[i])) {
       //   checkedStates.push(true)
// } else {
        checkedStates.push(false)
//      }
        }
    }

  $: checked = $active[1][n].sec[i].x.filter((_, i) => checkedStates[i]);

  function isWithin(min, max) {
    const l = checked.length
    if (max <= l) {
        disabled = true;
        prompt = false;
    } else {
        disabled = false;
        prompt = true;
    }
  }

  function editAnswer() {
      const state = []
      for (let i = 0; i < q.y.length; i++) {
          for (let j = 0; j < q.x.length; j++) {
            const x = q.x[j]
            const y = q.y[i]
            if (checkedStates[i].x[j]) {
                state.push({x: x, y: y})
            }
          }
      }
  }

  let q = $active[1][n].sec[i]

</script>

{#if q.y && (q.accept === "grid")}
  <div class="container">
    <div class="header">
      <div class="col"></div>
      {#each q.x as ox, i}
        <div class="col">{ox}</div>
      {/each}
    </div>
    {#each q.y as oy, j}
      <div class="entry">
        <div class="loc">{oy}</div>
        {#each q.x as ox, k}
          <div class="col">
            <input
              class="loc"
              type="checkbox"
              name={ox}
              bind:checked={checkedStates[j].x[k]}
              on:change={editAnswer}
            />
          </div>
        {/each}
      </div>
    {/each}
  </div>
{:else}
  <div class="container">
    {#each q.x as o, i}
      <div class="option">
        {#if !checkedStates[i] && q.max <= checked.length}
          <input 
            type="checkbox" 
            bind:checked={checkedStates[i]}
            on:change={isWithin(q.min, q.max)} 
            name={o}
            disabled
          />
        {:else}
          <input 
            type="checkbox" 
            bind:checked={checkedStates[i]}
            on:change={isWithin(q.min, q.max)} 
            name={o}
          />
        {/if}
        <div class="text">{o}</div>
      </div>
    {/each}
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
    flex: 1;
    text-align: right;
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
