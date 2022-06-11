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
<div class="container">
  <div class="num">
    Question {q.qid} 
  </div>
  <div class="text">
    {q.qtitle}
  </div>
  <input
    type="text" 
    placeholder="your answer"
    on:blur={handleUpdate}
    bind:value={ans}
  />
</div>

<style>

  .container {
    width: 80%;
    min-height: 6em;
    margin: auto;
    border-bottom: 1px solid black;
  }

  .num {
    margin: auto;
    text-align: center;
    border-bottom: 1px solid black;
  }

  .text {
    flex: 19;
    margin: 2em 0 2em 1em;
  }

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
