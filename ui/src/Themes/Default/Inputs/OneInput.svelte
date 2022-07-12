<script>

  import { active, editDraft } from '/src/UrbitStore'

  export let n, i

  let selected = []

  if ($active[2][n].sec[i].a.length > 0) {
    selected = $active[2][n].sec[i].a  
    console.log(selected)
  }

  function handleClick() {
      $active[2][n].sec[i].a = selected
      const data = {
        id: $active[0].id,
        sid: n + 1,
        qid: $active[1][n].sec[i].qid,
        head: "answer",
        accept: "text",
        a: $active[2][n].sec[i].a,
        b:[],
        c:[]
      }
      editDraft(data)  
  }


</script>

{#if $active[1][n].sec[i].y.length > 0}
  {#each $active[1][n].sec[i].y as oy, j}
    <div class="row">
      <div class="label">{oy}</div>
      {#each $active[1][n].sec[i].x as o}
        <button
          class="option {selected[j] === o ? "active" : ""}"
          on:click={()=>{selected[j] = o; handleClick()}}
        >
          {o}
        </button>
      {/each}
    </div>
  {/each}
{:else}
  {#if $active[1][n].sec[i].x.length > 0}
    <div class="row">
      {#each $active[1][n].sec[i].x as o}
        <button 
          class="option {selected[0] === o ? "active" : ""}"
          on:click={()=>{selected[0] = o; handleClick()}}
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
    flex: 2;
    text-align: right;
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

  .option:hover {
    border-color: grey;
    border-radius: 4px;
    background: grey;
    color: white;
  }

  .active {
    background: black;
    border-color: black;
    color: white;
  }

  .active:hover {
    background: black;
    border-color: black;
  }

</style>
