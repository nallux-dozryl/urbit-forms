<script>
  import { frontType, newQuestion } from '../UrbitStore'
  
  export let sid;
    let qType;

  function createQuestion() {
      const data = {
        surveyid: sid,
        qtitle: "",
        front: qType,
        back: "text",
        required: false,
        x: [],
        y: []
      }
    newQuestion(data)
    }

</script>



<div class="newq">
  <select 
    bind:value={qType}
    >
    {#each frontType as front}
      <option value={front}>
        {front}
      </option>
    {/each}
  </select>
  <button on:click={createQuestion}>Add Question</button>

</div>

<style>

  .newq {
    text-align: center; 
    padding: 2em;
  }

</style>
