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

<textarea
  placeholder="your answer"
  on:blur={handleUpdate}
  bind:value={ans}
/>

<style>

  textarea {
    border: none;
    width: 100%;
    padding: 1em;
    margin-bottom: .6em;
    color: black;
  
  }

  textarea:focus {
    background: white;
  }

</style>
