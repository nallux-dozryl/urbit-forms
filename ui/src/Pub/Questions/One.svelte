<script>
  import { editDraft } from '../../UrbitStore'

  export let q;
  export let sid;

  function handleUpdate(ox) {
    const data = {
      surveyid: sid,
      questionid: q.qid,
      ans: {text: ox}
    }
    editDraft(data) 
  }
</script>

<div class="container">
  {#if q.x}
    {#each q.x as ox, i}
    <div class="option">
      {#if ox === q.answer}
        <input 
          on:click={()=> handleUpdate(ox)}
          type="radio" 
          name="one"
          checked
        />
      {:else}
        <input 
          on:click={()=> handleUpdate(ox)}
          type="radio" 
          name="one"
        />
      {/if}
      <label>{ox}</label>
    </div>
    {/each}
  {/if}
</div>



<style>

  .container {
    display: flex;
    flex-direction: column;
  }

  .option {
    flex: 1;
  }

</style>
