<script>
  import { frontType, newQuestion } from '../UrbitStore'
  
  export let sid;
    let qType;

  function createQuestion() {
      const data = {
        surveyid: sid,
        qtitle: "",
        front: qType[1],
        back: qType[0],
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
        {front[1]}
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
