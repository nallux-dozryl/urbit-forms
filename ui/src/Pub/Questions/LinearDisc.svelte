<script>
  import { editDraft } from '../../UrbitStore'

  export let q;
  export let sid;

  function handleUpdate() {
    const data = {
      surveyid: sid,
      questionid: q.qid,
      ans: {text: q.answer.toString()}
    }
    editDraft(data)
  }
  

</script>
<div class="container">
  <input 
    class="slider"
    type="range" 
    min={q.x[0]} 
    max={q.y[0]}
    bind:value={q.answer}
    on:blur={handleUpdate}
  />
  <div class="res">{q.answer}</div>
</div>

<style>
  
  .res {
    text-align: center;
  }

  .slider {
    -webkit-appearance: none;  /* Override default CSS styles */
    appearance: none;
    width: 100%; /* Full-width */
    height: 25px; /* Specified height */
    background: #d3d3d3; /* Grey background */
    outline: none; /* Remove outline */
  }

  .slider::-webkit-slider-thumb {
    -webkit-appearance: none; /* Override default look */
    appearance: none;
    width: 25px; /* Set a specific slider handle width */
    height: 25px; /* Slider handle height */
    background: black; /* Green background */
    cursor: pointer; /* Cursor on hover */
  }

  .slider::-moz-range-thumb {
    width: 25px; /* Set a specific slider handle width */
    height: 25px; /* Slider handle height */
    background: black; /* Green background */
    cursor: pointer; /* Cursor on hover */
  }

  .container {
    min-height: 6em;
    margin: auto;
    max-width: 80%;
    border-bottom: 1px solid black;
  }

</style>
