<script>
  import { active, addQuestion } from '../UrbitStore'

  export let n, i

  function makeRequired() {
    $active[1][n].sec[i].required = !$active[1][n].sec[i].required
    const q = $active[1][n].sec[i]
    q["id"] = $active[0].id
    q["sid"] = n + 1
    addQuestion(q)
    active.set($active)
  }

  function changeQuestion() {
    const q = $active[1][n].sec[i]
    console.log(q)  
  }


</script>

<div class="container">
  <div class="type">
    <select on:change{changeQuestion} bind:value={$active[1][n].sec[i].display}>
      <option value="text-input">Text</option>
      <option value="one-input">Multiple Choice</option>
      <option value="range-input">Range</option>
      <option value="many-input">Multiple Selection</option>
      <option value="cal-input">Calendar</option>
    </select>
  </div>
  <div class="req">
    {#if $active[1][n].sec[i].required}
      <button class="active" on:click={makeRequired}>Required</button>
    {:else}
      <button on:click={makeRequired}>Not Required</button>
    {/if}
  </div>
</div>

<style>

  .container {
    margin-top: 2em;
    display: flex;
  }

  .req {
    flex: 1;
    text-align: right;
  }

  .req button {
    padding: .6em; 
    border: solid 1px #e9e9e9;
    color: #e9e9e9;
    background: none;
    border-radius: 4px;
    width: 8em;
  }

  .req button:hover {
    color: white;
    background: grey;
    border-color: grey;
  }

  .req .active {
    background: black;
    border-color: black;
    color: white;
  }

  .type {
    text-align: left;
  }

  select {
    width: 12em;
    text-align: center;
    padding: .6em 0 .6em 0;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    background: white;
  }

</style>
