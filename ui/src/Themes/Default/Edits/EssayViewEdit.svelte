<script>
  
  import { active, addQuestion } from '../../../UrbitStore'

  export let i, n, j

  function handleUpdate() {
      const q = $active[1][n].sec[i]  
      q["id"] = $active[0].id,
      q["sid"] = n + 1
      addQuestion(q) 
  }

    function delStatement() {
      $active[1][n].sec[i].statements.splice(j, 1)
      const q = $active[1][n].sec[i]
      q["id"] = $active[0].id,
      q["sid"] = n + 1
      addQuestion(q)
      active.set($active)
  }

</script>

<div class="container">
  <div class="up">
    <div class="words">Description</div>
    <div class="x">
      <button on:click={delStatement}>x</button>
    </div>
  </div>
  <textarea
    bind:value={$active[1][n].sec[i].statements[j].x[0]}
    on:blur={handleUpdate}
  />
</div>

<style>

  .container {
    display: flex;
    flex-direction: column;
    padding-bottom: 1em;
  }

  .up {
    display: flex;
    align-items: center;
  }

  .words {
    flex: 1;
    font-size: .7em;
    color: #666;
    padding: .3em 0 .3em 1em;
  }

  .x {
    text-align: right;
  }

  .x button {
    text-align: center;
    font-weight: 600;
    font-size: .5em;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    margin-bottom: .3em;
    padding: .3em .6em .3em .6em;
    color: #e9e9e9;
    background: none;
  }

  .x button:hover {
    background: #ffa1a1;
    border-color: #ffa1a1;
    color: white;
  }

  .x button:active {
    background: red;
    border-color: red;
  }

  textarea {
    flex: 1;
    border: none;
    background: #e9e9e9;
    height: 10em;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
    resize: vertical;
  }

  textarea:focus {
    outline: none;
  }

</style>
