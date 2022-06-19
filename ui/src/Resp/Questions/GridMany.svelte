<script>
  import { editDraft } from '../../UrbitStore'

  export let q;
  export let sid;

  let coord = q.answer;
/*
  function checkExist(ans, cur) {
      for (let i = 0; i < ans.length; i++) {
          if ((ans[i].x === cur.x) && (ans[i].y === cur.y))
          return true;
      }
      return false;
  }
*/
  function handleUpdate(ox) {
    const data = {
      surveyid: sid,
      questionid: q.qid,
      ans: {grid: coord}
    }
    editDraft(data) 
  }
</script>
{JSON.stringify(coord)}
<div class="container">
  <div class="row-names">
  {#if q.y}
    <br class="row" />
    {#each q.y as oy, i}
      <div class="row">{oy}</div>
    {/each}
  {/if}
  </div>
  {#if q.x}
    {#each q.x as ox, ix}
      <div class="column-row">
        {#if q.y}
          <div class="row">{ox}</div>
          {#each q.y as oy, iy}
            <div class="row">
              <input 
                type="checkbox" 
                on:blur={handleUpdate} 
                bind:group={coord}
                value={{x:ox,y:oy}}
                />
            </div>
          {/each}
        {/if}
      </div>
    {/each}
  {/if}
</div>

<style>

  .container {
    display: flex;
  }

  .row-names {
    display: flex;
    flex: 1;
    flex-direction: column;
  }

  .row {
    text-align: right;
    flex: 1;
  }

  .column-row {
    flex: 1;
    text-align: center;
  }

</style>
