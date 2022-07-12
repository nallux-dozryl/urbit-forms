<script>
  import QuestionEdit from './QuestionEdit.svelte'
  import MakeQuestion from './MakeQuestion.svelte'

  import { active, addSection, delSection } from '../UrbitStore'


    function makeSection() {
      const n = $active[1].length + 1
      $active[1].push({sec:[], sid:n})
      addSection({id: $active[0].id, sid:n})
      active.set($active) 
    }

    function removeSection(i) {
        delSection(
            {id: $active[0].id, sid:i},
            "~" + $active[0].author + "/" + $active[0].slug
        )
    }

</script>
<div class="container">
  {#if $active[1].length > 0}
  {#each $active[1] as sec, i}
    <div class="section">
      <div class="del">
        <button on:click={removeSection(sec.sid)}>X</button>
      </div>
      {#if $active[1].length > 1}
        <div class="title">
          Section {i+1}
        </div>
      {/if}
      <!--
      <div class="section-details">
        <button>Add section title</button>
        <button>Add section description</button>
      </div>
      -->
      <QuestionEdit n={i}/>
      <MakeQuestion n={i}/>
    </div>
  {/each}
  {/if}
  <button
    class="add"
    on:click={makeSection}
  >
    Add section
  </button>
</div>
<style>

  .del {
    text-align: right;
  }

  .title {
    text-align: center;
  }

  .del button {
    font-size: .6em;
    background: #e6e6e6;
    color: white;
    border: none;
    border-radius: 4px;
    margin: .3em;
    width: 2em;
    height: 2em;
    font-weight: 600;
  }

  .del button:hover {
    background: #ffa1a1;
  }

  .del button:active {
    background: red;
  }

  .add {
    margin: 2em 1em 2em 1em;
    border: solid 1px #e9e9e9;
    padding: 1em;
    border-radius: 6px;
    background: white;
  }

  .add:hover {
    color: white;
    background: grey;
    border-color: grey;
  }

  .add:active {
    background: black;
    border-color: black;
  }

  .container {
    display: flex;
    flex-direction: column;
  }

  .section {
    margin-top: 2em;
    padding: 1em 2em 2em 2em;
    background: #f0f0f0;
    margin-top: 2em;
    border-radius: 8px;
  }

  .section-details {
    display: flex;
    gap: 1em;
    justify-content: center;
  }

  .section-details button {
    margin-top: 2em;
    flex: 1;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    padding: 1em;
    background: white;
    max-width: 16em;
  }

  .section-details button:hover {
    color: white;
    border-color: grey;
    background: grey;
  }

  .section-details button:active {
    border-color: black;
    background: black;
  }

</style>
