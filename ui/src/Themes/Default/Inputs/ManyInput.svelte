<script>

  import { active, editDraft } from '/src/UrbitStore'

  export let n, i

  let checkedStates = [];

  if ($active[1][n].sec[i].accept === "grid") {
    for (let q = 0; q < $active[1][n].sec[i].y.length; q++) {
      checkedStates.push({ y: $active[1][n].sec[i].y[q], x: []})
      
      const exes = []
      for (let w = 0; w < $active[2][n].sec[i].b.length; w++) {
        if ($active[2][n].sec[i].b[w].y === $active[1][n].sec[i].y[q]) {
            exes.push($active[2][n].sec[i].b[w].x)
        }
      }
      for (let h = 0; h < $active[1][n].sec[i].x.length; h++) {
          if (exes.includes($active[1][n].sec[i].x[h])) {
              checkedStates[q].x.push(true)
          } else {
              checkedStates[q].x.push(false)
          }
      }
    }
  }

  if ($active[1][n].sec[i].accept === "list") {
      for (let g = 0; g < $active[1][n].sec[i].x.length; g++) {
          if ($active[2][n].sec[i].a.includes($active[1][n].sec[i].x[g])) {
              checkedStates.push(true)
          } else {
              checkedStates.push(false)
          }
      }
  }

  $: checked = $active[1][n].sec[i].x.filter((_, i) => checkedStates[i]);

  let gridChecked = []

  function handleGrid() {
      gridChecked = []
      for (let f = 0; f < checkedStates.length; f++) {
          for (let d = 0; d < checkedStates[f].x.length; d++) {
              if (checkedStates[f].x[d]) {
                  gridChecked.push(
                      {
                          x: $active[1][n].sec[i].x[d],
                          y: $active[1][n].sec[i].y[f]
      })}}}
      const data = {
        id: $active[0].id,
        sid: n + 1,
        qid: $active[1][n].sec[i].qid,
        head: "answer",
        accept: "grid",
        a:[],
        b:gridChecked,
        c:[]
      }
      editDraft(data)  
  }

  function handleList() {
      $active[2][n].sec[i].a = checked
      const data = {
        id: $active[0].id,
        sid: n + 1,
        qid: $active[1][n].sec[i].qid,
        head: "answer",
        accept: "list",
        a: $active[2][n].sec[i].a,
        b:[],
        c:[]
      }
      editDraft(data)  
  }



</script>
{#if $active[1][n].sec[i].y.length > 0}
  <div class="container">
    <div class="header">
      <div class="col"></div>
      {#each $active[1][n].sec[i].x as ox, j}
        <div class="col">{ox}</div>
      {/each}
    </div>
    {#each $active[1][n].sec[i].y as oy, m}
      <div class="entry">
        <div class="loc">{oy}</div>
        {#each $active[1][n].sec[i].x as ox, n}
          <div class="col">
            <input
              class="loc"
              type="checkbox"
              name={ox}
              bind:checked={checkedStates[m].x[n]}
              on:change={handleGrid}
            />
          </div>
        {/each}
      </div>
    {/each}
  </div>
{:else}
  <div class="container">
    {#each $active[1][n].sec[i].x as o, j}
      <div class="option">
          <input 
            type="checkbox" 
            name={o}
            bind:checked={checkedStates[j]}
            on:change={handleList}
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
