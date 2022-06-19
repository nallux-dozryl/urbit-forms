<script>
  import { editDraft } from '../UrbitStore'

  export let qid; 
    export let sid;

    let ans;

  function handleUpdate() {
      const data = {
          surveyid: sid,
          questionid: qid,
    //      text: {answer: ans}
        }
      editDraft(data)
    }
  
</script>
{sid}
{qid}
<input
  type="text" 
  placeholder="your answer"
  on:blur={handleUpdate}
  bind:value={ans}
/>


<style>

  input {
    width: 80%;
    border: none;
    padding: 1em;
    margin-bottom: .6em;
    color: black;
  
  }

  input:focus {
    background: white;
  }

</style>
