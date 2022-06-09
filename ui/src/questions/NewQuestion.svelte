<script>
  let qType;
  let frontType = [
      "statement", 
      "short", 
      "long", 
      "one", 
      "grid-one", 
      "grid-many",
      "linear-discrete",
      "linear-continuous",
      "calendar"
  ]
</script>



<div>
  <select 
    bind:value={qType}
    >
    {#each frontType as front}
      <option value={front}>
        {front}
      </option>
    {/each}
  </select>
  <button on:click={()=> console.log(qType)}>click me</button>

</div>
