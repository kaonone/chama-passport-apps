import React from 'react'
import {
  AragonApp,
  Button,
  Text,

  observe
} from '@aragon/ui'
import Aragon, { providers } from '@aragon/client'
import styled from 'styled-components'

const AppContainer = styled(AragonApp)`
  display: flex;
  align-items: center;
  justify-content: center;
`

export default class App extends React.Component {
  render () {
    return (
      <AppContainer>
        <div>
          {/* <ObservedCount observable={this.props.observable} /> */}
          <ObservedIdentity observable={this.props.observable} />
          <Button onClick={() => this.props.app.register(42, "Foo", "Boo")}>Registration</Button>
        </div>
      </AppContainer>
    )
  }
}

// const ObservedCount = observe(
//   (state$) => state$,
//   { count: 0 }
// )(
//   ({ count }) => <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>{count}</Text.Block>
// )

const ObservedIdentity = observe(
  (state$) => state$,
  { count: 0, identity: null }
)(
  ({ count, identity }) => {
    console.log('>> identity', identity);
    return [
      <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>Count: {count}</Text.Block>,
      identity
        ? (<React.Fragment>
          <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>Age: {identity.age}</Text.Block>
          <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>First name: {identity.firstName}</Text.Block>
          <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>Last name: {identity.lastName}</Text.Block>
        </React.Fragment>)
        : <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>Identity is not found</Text.Block>
      
    ];
  }
)
