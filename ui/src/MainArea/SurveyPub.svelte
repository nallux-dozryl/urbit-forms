<script>
  //imports
  import QContainer from '../Pub/QContainer.svelte'

  // Defining things
  export let survey;

</script>

<div class="container">
  {#each survey[1] as q}
    <QContainer qs={q}/>
  {/each} 
</div>

<style>

  .container {
    width: 80%;
    margin: auto;
  }

</style>
