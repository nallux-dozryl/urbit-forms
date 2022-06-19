<script>
  import { editDraft } from '../../UrbitStore'

  export let q
  export let sid

  let ans = q.answer

  function handleUpdate() {
      const data = {
          surveyid: sid,
          questionid: q.qid,
          ans: {text: ans}
        }
      editDraft(data)
  }
</script>

<input
  type="text" 
  placeholder="your answer"
  on:blur={handleUpdate}
  bind:value={ans}
/>

<style>

  input {
    border: none;
    width: 90%;
    padding: 1em;
    margin-bottom: .6em;
    color: black;
  
  }

  input:focus {
    background: white;
  }

</style>
