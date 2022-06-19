<script>

  export let q;
  export let ans;

</script>

<div class="container">
  {#each ans.answers as a}
    {#if q.qid === a.id}
      <input class="slider" type="range" value={a.answer} disabled />
      <div class="res">{a.answer}</div>
    {/if}
  {/each}
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
