<script>

  import { active, addQuestion } from '../../../UrbitStore'

  export let i, n

  function switchAccept() {
      if ($active[1][n].sec[i].y.length > 0) {
        return "grid"  
        }
      return "list"
  }

  function addCol() {
      const  q = $active[1][n].sec[i]
      q.x.push('')  
      q["accept"] = switchAccept()
      active.set($active)
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
    }

  function addRow() {
      const  q = $active[1][n].sec[i]
      q.y.push('')  
      q["accept"] = switchAccept()
      active.set($active)
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
    }

  function delCol(k) {
      const  q = $active[1][n].sec[i]
      q.x.splice(k, 1)
      q["accept"] = switchAccept()
      active.set($active)
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
  }

  function delRow(h) {
      const  q = $active[1][n].sec[i]
      q.y.splice(h, 1)
      q["accept"] = switchAccept()
      active.set($active)
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
  }

  function handleUpdate() {
      const  q = $active[1][n].sec[i]
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
  }
</script>
<div class="container">
  {#if $active[1][n].sec[i].y.length > 0}
    <div class="row-block">
      {#each $active[1][n].sec[i].y as oy, h}
        <div class="col">
          <input type="text" bind:value={oy} on:blur={handleUpdate}/>
          <button class="del" on:click={()=>delRow(h)}>x</button>
        </div>
      {/each}
    </div>
  {/if}
  <div class="col-block">
    {#each $active[1][n].sec[i].x as ox, k}
      <div class="col">
        <input type="text" bind:value={ox} on:blur={handleUpdate}/>
        <button class="del" on:click={()=>delCol(k)}>x</button>
      </div>
    {/each}
  </div>
</div>
<div class="container">
  {#if $active[1][n].sec[i].y.length > 0}
    <button class="add-col" on:click={addRow}>
      Add Row
    </button>
    <button class="add-col" on:click={addCol}>
      Add Column
    </button>
  {:else}
    <button class="add-col" on:click={addCol}>
      Add Option
    </button>
  {/if}
</div>
{#if $active[1][n].sec[i].y.length < 1}
  <div class="container">
    <button on:click={addRow} class="to-row">
      Change to grid
    </button>
  </div>
{/if}
<style>

  .container {
    display: flex;
    margin: 1em;
    align-items: flex-start;

  }

  .to-row {
    background: none;
    border: solid 1px #e9e9e9;
    padding: .6em;
    width: 10em;
    border-radius: 4px;
    font-size: .8em;
  }

  .to-row:hover {
    background: grey;
    border-color: grey;
    color: white;
  }

  .to-row:active {
    background: black;
  }

  .del {
    font-size: .6em;
    width: 2em;
    height: 2em;
    border: solid 1px #e9e9e9;
    color: #e9e9e9;
    background: none;
    border-radius: 4px;
  }

  .del:hover {
    background: #ffa1a1;
    border-color: #ffa1a1;
    color: white;
  }

  .del:active {
    background: red;
    border-color: red;
  }

  .add-col {
    flex: 1;
    background: white;
    padding: .6em;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
  }

  .add-col:hover {
    background: grey;
    border-color: grey;
    color: white;
  }

  .add-col:active {
    background: black;
    border-color: black;
  }

  .col-block {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: .3em;
    margin: 1em;
  }

  .row-block {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: .3em;
    margin: 1em;
  }

  .col {
    flex: 1;
    display: flex;
    gap: 1em;
    align-items: center;
  }

  .col input {
    flex: 1;
    border: none;
    padding: .8em;
    background: #e9e9e9;
    border-radius: 4px;
  }

  .col input:focus {
    outline: none;
  }


</style>
