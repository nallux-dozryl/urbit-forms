<script>
  import { active, editTitle } from '../../UrbitStore'

</script>

<div class="section">
  <div class="title">Title</div>
  <div class="arg">
    <input
      class="title-input"
      type="text"
      bind:value={$active[0].title}
      on:blur={editTitle({id: $active[0].id, title: $active[0].title})}
    />
  </div>
</div>

<style>


  .section {
    margin: 2em 0 2em .6em;
  }

  .title {
    font-size: 1.2em;
    font-weight: 500;
  }

  .arg {
    margin-top: 1em;
    font-size: .8em;
  }

  input {
    border: none;
    background: #e9e9e9;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
  }

  .title-input {
    width: 100%;
    box-sizing: border-box;

  }

  input:focus {
    outline: none;
  }

</style>
