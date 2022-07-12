<script>

  import { submitting, active, submitResponse } from '../UrbitStore'
  import Question from './Question.svelte'


  let nsec = $active[1].length
  let n = 0

  function changeSection(cmd) {
      if ((n > 0) && (cmd === "dec")) { --n }
      if ((n < nsec - 1) && (cmd === "inc")) { ++n }
  }

  function makeAnsSection() {
    $active[2].push({sec:[],sid: n+1})
    active.set($active)
  }

  function handleSubmit() {
    $submitting = true
    submitResponse({id:$active[0].id})    
  }

</script>
<div class:blur={$submitting}>
  <div class="section">
    {#if $active[2][n] === undefined}
      {makeAnsSection()}
    {/if}
    {#if nsec > 0}
      {#if nsec > 1}
        <div class="section-number">Section {n + 1} of {nsec}</div>
      {/if}
      {#each $active[1][n].sec as q, i}
        <Question {i} {n} {nsec} />
      {/each}
    {/if}
  </div>
  <div class="buttons">
    {#if n > 0}
      <button class="toggler" on:click={()=>changeSection("dec")}>Previous</button>
    {/if}
    {#if n < nsec - 1}
      <button class="toggler" on:click={()=>changeSection("inc")}>Next</button>
    {:else}
      <button class="submit" on:click={handleSubmit}>Submit</button>
    {/if}
  </div>
</div>
<style>

  .blur {
    filter: blur(4px);
    pointer-events: none;
  }

  .section {
    margin-top: 1em;
  }

  .section-number {
    text-align: center;
    font-size: 1.2em;
    font-weight: 500;
    margin-bottom: 1em;
  }

  .buttons {
    padding: 0 0 2em 0;
  }

  .toggler {
    font-size: .8em;
    padding: .6em 1em .6em 1em;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    width: 6em;
    background: white;
    margin-right: 1em;
  }

  .toggler:hover {
    color: white;
    background: grey;
    border-color: grey;
  }

  .toggler:active {
    color: white;
    background: black;
    border-color: black;
  }

  .submit {
    font-size: .8em;
    padding: .6em 1em .6em 1em;
    width: 6em;
    border: solid 1px black;
    background: black;
    color: white;
    border-radius: 4px;
  }

  .submit:hover {
    background: grey;
    border-color: grey;
  }

  .submit:active {
    background: white;
    color: black;
    border: none;
  }

</style>
