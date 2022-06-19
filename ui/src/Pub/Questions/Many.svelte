<script>
  import { editDraft } from '../../UrbitStore'

  export let q;
  export let sid;
  let checkedStates = [];

  for (let i = 0; i < q.x.length; i++) {
      if (q.answer.includes(q.x[i])) {
          checkedStates.push(true)
      } else {
      checkedStates.push(false)
      }
  }

  $: checked = q.x.filter((_, i) => checkedStates[i]);

    function handleUpdate() {
      const data = {
          surveyid: sid,
          questionid: q.qid,
          ans: {list: checked}
        }
      editDraft(data)
  }

</script>
<div class="container">
  {#if q.x}
    {#each q.x as ox, i}
    <div class="option">
        <input 
          type="checkbox" 
          name={ox}
          bind:checked={checkedStates[i]}
          on:change={handleUpdate}
        />
      <span>{ox}</span>
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
