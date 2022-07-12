<script>
  import { active, addQuestion } from '../UrbitStore'
  import { edits } from '../Themes/Default/config'

  export let n
  export let i

  function handleCreate(view) {
      $active[1][n].sec[i].statements.push({
          x:[''],
          y:[''],
          z:[''],
          display: view
      })
      const q = $active[1][n].sec[i]
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
      active.set($active)
  }

</script>
{#each $active[1][n].sec[i].statements as statement, j}
  {#each edits as b}
    {#if b.display === statement.display}
      <svelte:component this={b.component} {i} {n} {j}/>
    {/if}
  {/each}
{/each}
<div class="add">
  <button on:click={()=> handleCreate("title-view")}>
    Add Title
  </button>
  <button on:click={()=> handleCreate("essay-view")}>
    Add Description
  </button>
</div>

<style>
 
  .add {
    margin: 0 0 2em 1em;
  }

  .add button{
    width: 12em;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    padding: .6em 0 .6em 0;
    background: white;
  }

  .add button:hover {
    background: grey;
    border-color: grey;
    color: white;
  }

  .add button:active {
    background: black;
    border-color: black;
  }

</style>
